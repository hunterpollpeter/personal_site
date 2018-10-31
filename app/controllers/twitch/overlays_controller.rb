module Twitch
  class OverlaysController < BaseController
    def index
      @templates = OverlayTemplate.templates.keys
      @overlays = Overlay.all
    end

    def new

    end

    def template
      @name = overlays_params[:name]
      @settings = OverlayTemplate.templates[@name]
      @scripts = OverlayTemplate.scripts(name: @name)
      @styles = OverlayTemplate.styles(name: @name)

      render "twitch/overlay_templates/#{@name}", layout: OverlayTemplate.layout
    end

    private

    def overlays_params
      params.permit(%i[name])
    end
  end
end