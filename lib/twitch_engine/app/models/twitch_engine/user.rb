# frozen_string_literal: true

require 'httparty'
include ActionView::Helpers::DateHelper

module TwitchEngine
  class User < ApplicationRecord
    devise :database_authenticatable, :omniauthable, omniauth_providers: %i[twitch spotify]
    has_many :overlays

    def self.from_omniauth(auth)
      where(uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.username = auth.info.nickname
        user.image_url = auth.info.image
        user.token = auth.credentials.token
        user.data = auth
      end
    end

    def spotify_credentials!(credentials)
      expires_at = credentials&.fetch(:expires_at)
      return unless expires_at
      expires_at = DateTime.strptime(expires_at.to_s,'%s')
      update_attributes!(
          spotify_token: credentials&.fetch(:token),
          spotify_refresh_token: credentials&.fetch(:refresh_token),
          spotify_expires: expires_at
      )
    end

    def overlay_data(topics)
      ret = {}
      topics&.each do |topic|
        ret[topic] = send(topic) if self.class.topic_allowed?(topic)
      end
      ret
    end

    private

    def self.topic_allowed?(topic)
      %w[spotify_currently_playing most_recent_follower].include?(topic)
    end

    def spotify_currently_playing
      # check if spotify is connected
      return nil unless spotify_connected?
      # refresh token if it is expired
      refresh_spotify_auth! if spotify_token_expired?
      resp = HTTParty.get(self.class.spotify_currently_playing_path, headers: { 'Authorization': "Bearer #{spotify_token}" })
      track = resp&.fetch('item')
      {
          title: track.fetch('name'),
          artists: track.dig('artists').map {|artist| artist.fetch('name')}.to_sentence,
          album_image: track.dig('album', 'images')[1].fetch('url'),
          # add 3 seconds for delay
          duration_pct: (((resp.fetch('progress_ms').to_f + 3000) / track.fetch('duration_ms')) * 100).round(1),
          is_playing: resp.fetch('is_playing')
      } if track
    end

    def most_recent_follower
      recent_follower = self.data['recent_follower'] || get_most_recent_follower
      {
          user_name: recent_follower['user_name'],
          followed_ago: "#{time_ago_in_words(recent_follower['from'])} ago",
          user_image: recent_follower['user_image']
      }
    end

    def get_most_recent_follower
      resp = HTTParty.get(self.class.twitch_followers_path, query: { to_id: self.data['uid'], first: 1 }, headers: { 'Client-ID': ENV['TWITCH_CLIENT_ID'] })
      resp_data = resp['data'][0]
      recent_follower_id = resp_data['from_id']
      recent_follower = {
          'id': recent_follower_id,
          'user_name':  resp_data['from_name'],
          'user_image': self.class.user_image(recent_follower_id),
          'from': resp_data['followed_at']
      }
      self.data['recent_follower'] = recent_follower
      self.save
      recent_follower
    end

    def self.user_image(user_id)
      resp = HTTParty.get(twitch_user_path, query: { id: user_id }, headers: { 'Client-ID': ENV['TWITCH_CLIENT_ID'] })
      resp['data'][0]['profile_image_url']
    end

    def self.spotify_refresh_token_path
      'https://accounts.spotify.com/api/token'
    end

    def self.spotify_currently_playing_path
      'https://api.spotify.com/v1/me/player/currently-playing'
    end

    def self.twitch_followers_path
      'https://api.twitch.tv/helix/users/follows'
    end

    def self.twitch_user_path
      'https://api.twitch.tv/helix/users'
    end

    def refresh_spotify_auth!
      resp = HTTParty.post(self.class.spotify_refresh_token_path,
                           body: {
                             grant_type: 'refresh_token',
                             refresh_token: spotify_refresh_token
                           },
                           headers: {
                             'Authorization': "Basic #{self.class.spotify_client_authorization}"
                           }
                          )
      return unless resp.code == 200
      expires_at = DateTime.now + resp['expires_in'].to_i.seconds
      self.update_attributes!(spotify_token: resp['access_token'], spotify_expires: expires_at)
    end

    def spotify_token_expired?
      spotify_expires <= DateTime.now
    end

    def spotify_connected?
      !!spotify_refresh_token
    end

    def self.spotify_client_authorization
      Base64.urlsafe_encode64("#{ENV['SPOTIFY_CLIENT_ID']}:#{ENV['SPOTIFY_CLIENT_SECRET']}")
    end
  end
end
