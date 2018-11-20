module TwitchEngine
  class OverlayTemplate < ApplicationRecord
    @templates = {}

    class << self
      attr_accessor :templates
    end

    def self.overlay_template(id, name, options)
      templates[id] = { name: name, options: options }
    end

    def self.layout
      'twitch_engine/overlay_templates/base'
    end

    # modern template
    overlay_template 1, 'modern',
                     element_priority: %i[webcam most_recent_follower spotify_currently_playing],
                     elements: {
                       webcam: {
                         enabled: true
                       },
                       most_recent_follower: {
                         enabled: true
                       },
                       spotify_currently_playing: {
                         requires: %i[spotify_enabled],
                         enabled: true
                       }
                     }

  end
end