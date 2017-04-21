# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    it 'to success' do
      get users_path
      assert_response :success
    end
  end
  describe 'GET /@:login' do
    it 'to success' do
      user = create(:user)
      get user_path login: user.login
      assert_response :success
    end
  end
  describe 'DELETE /@:login' do
    it 'to success' do
      user = create(:user)
      delete user_path login: user.login
      assert_response :redirect
    end
  end
end
