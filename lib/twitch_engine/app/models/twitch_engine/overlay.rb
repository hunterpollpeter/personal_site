module TwitchEngine
  class Overlay < ApplicationRecord
    belongs_to :user

    def self.make(user, template_name)
      Overlay.create(user: user, name: 'New Overlay', template_name: template_name, options: OverlayTemplate.templates[template_name].defaults)
    end
  end
end