module TwitchEngine
  class OverlaysController < ApplicationController
    skip_before_action :verify_authenticity_token #TODO: make it work without using this

    def index
      @templates = OverlayTemplate.templates
      @overlays = current_user&.overlays&.all
    end

    def create
      overlay = Overlay.make(current_user, overlays_params[:template_id])
      redirect_to edit_twitch_overlay_path(id: overlay.id)
    end

    def edit
      @overlay = Overlay.find_by(id: overlays_params[:id])
      @elements = @overlay.prioritized_elements
    end

    def update
      Overlay.find_by(id: overlays_params[:id])&.update_options(overlays_options_params)
    end

    def template
      render "twitch_engine/overlay_templates/#{@template[:name]}/index", layout: OverlayTemplate.layout
    end

    def preview_template
      @template = OverlayTemplate.templates[overlays_params[:id].to_i]
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
      @elements = @overlay.prioritized_elements
      template
    end

    private

    def overlays_params
      params.permit(%i[id template_id options])
    end

    def overlays_options_params
      params.require(:options).permit!
    end
  end
end