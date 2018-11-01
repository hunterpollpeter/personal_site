module TwitchEngine
  class OverlaysController < ApplicationController
    def index
      @templates = OverlayTemplate.templates.keys
      @overlays = current_user&.overlays&.all
    end

    def template
      @name = overlays_params[:name]
      @settings = OverlayTemplate.templates[@name]
      @scripts = OverlayTemplate.scripts(name: @name)
      @styles = OverlayTemplate.styles(name: @name)

      render "twitch_engine/overlay_templates/#{@name}", layout: OverlayTemplate.layout
    end

    private

    def overlays_params
      params.permit(%i[name])
    end
  end
end