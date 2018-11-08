module TwitchEngine
  class OverlaysController < ApplicationController
    def index
      @templates = OverlayTemplate.templates.keys
      @overlays = current_user&.overlays&.all
    end

    def create
      overlay = Overlay.make(current_user, overlays_params[:name])
      redirect_to edit_twitch_overlay_path(id: overlay.id)
    end

    def edit
      @overlay = Overlay.find_by(id: overlays_params[:id])
    end

    def template
      @options = @options.with_indifferent_access
      @name = @template[:name]
      # @scripts = OverlayTemplate.scripts(name: @name)
      # @styles = OverlayTemplate.styles(name: @name)

      render "twitch_engine/overlay_templates/#{@name}", layout: OverlayTemplate.layout
    end

    def preview_template
      @template = OverlayTemplate.templates[overlays_params[:id].to_i]
      @options = OverlayTemplate.defaults(@template)
      @preview = true
      template
    end

    def preview
      @preview = true
      show
    end

    def show
      @overlay = Overlay.find_by(id: overlays_params[:id])
      @template = OverlayTemplate.templates[@overlay.template_id]
      @options = @overlay.options
      template
    end

    private

    def overlays_params
      params.permit(%i[id])
    end
  end
end