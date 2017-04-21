# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(res)
    request.env['omniauth.origin'] || stored_location_for(res) || root_path
  end
end
