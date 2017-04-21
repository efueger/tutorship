# frozen_string_literal: true

module Users
  class SessionsController < Devise::OmniauthCallbacksController
    def github
      @user = User.find_or_create_by(payload)
      sign_in_and_redirect @user
    end

    def payload
      request.env['omniauth.auth']
    end
  end
end
