module TwitchEngine
  class OverlayTemplate < ApplicationRecord
    @templates = {}

    class << self
      attr_accessor :templates
    end

    def self.overlay_template(id, name, options:)
      templates[id] = { name: name, options: options }
    end

    def self.layout
      'twitch_engine/overlay_templates/base'
    end

    def self.defaults(template)
      options = {}
      template[:options].each { |k, v| options[k] = v[:default] }
      options
    end

    # modern template
    overlay_template 1, 'modern',
                     options: {
                       name: {
                         type: :text,
                         default: 'Your Name'
                       }
                     }
  end
end