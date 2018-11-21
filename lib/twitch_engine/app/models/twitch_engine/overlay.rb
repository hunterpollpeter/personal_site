module TwitchEngine
  class Overlay < ApplicationRecord
    belongs_to :user

    def self.make(user, template_id)
      Overlay.create(user: user, name: 'New Overlay', template_id: template_id, options: [])
    end

    def prioritized_elements
      elements = self.elements
      priority = {}
      self.element_priority.each do |key|
        priority[key] = elements[key]
      end
      priority
    end

    def update_options(new_options)
      self.options.deep_merge!(new_options)
      self.save
    end

    def elements
      OverlayTemplate.templates[template_id].dig(:options, :elements).deep_merge(options.deep_symbolize_keys.fetch(:elements, nil) || {})
    end

    def element_priority
      priority = options.fetch(:element_priority, nil) || []
      priority + (OverlayTemplate.templates[template_id].dig(:options, :element_priority) - priority)
    end
  end
end