module TwitchEngine
  module ApplicationHelper
    def nav_link(link_text, link_path, controller)
      class_name = current_controller?(controller) ? 'active' : ''
      content_tag(:li, class: "nav-item #{class_name}") do
        link_to link_text, link_path, class: 'nav-link'
      end
    end

    def nav_link_block(link_path, controller, &block)
      class_name = current_controller?(controller) ? 'active' : ''
      content_tag(:li, class: "nav-item #{class_name}") do
        link_to link_path, class: 'nav-link', &block
      end
    end

    def true?(obj)
      obj.to_s == 'true'
    end

    private

    def current_controller?(controller)
      params[:controller] == "twitch_engine/#{controller}"
    end
  end
end
