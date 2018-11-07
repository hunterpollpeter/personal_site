module TwitchEngine
  class OverlayTemplate < ApplicationRecord
    @templates = {}

    class << self
      attr_accessor :templates
    end

    def self.overlay_template(name, options:)
      templates[name] = options
    end

    def self.styles(name:)
      asset_files(name: name, path: styles_path)
    end

    def self.scripts(name:)
      asset_files(name: name, path: scripts_path)
    end

    def self.layout
      'twitch_engine/overlay_templates/base'
    end

    def self.defaults(name:)
      options = {}
      templates[name].each { |k, v| options[k] = v[:default] }
      options
    end

    private

    def self.assets_path
      TwitchEngine::Engine.root.join('app', 'assets')
    end

    def self.scripts_path
      assets_path.join('javascripts')
    end

    def self.styles_path
      assets_path.join('stylesheets')
    end

    def self.overlay_templates_path(name:, path:)
      path.join('twitch_engine', 'overlay_templates', name)
    end

    def self.asset_files(name:, path:)
      asset_path = overlay_templates_path(name: name, path: path)
      relative_path = asset_path.relative_path_from(path)
      Dir.entries(asset_path).drop(2).map { |p| "#{relative_path}/#{p}" }
    end

    # particles template
    overlay_template 'particles', options: {
      color: {
        type: :color,
        default: '#e25600'
      },
      name: {
        type: :text,
        default: 'Your Name'
      }
    }
  end
end