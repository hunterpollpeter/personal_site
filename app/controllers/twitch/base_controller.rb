module Twitch
  class BaseController < ApplicationController
    layout 'twitch', except: :template
  end
end