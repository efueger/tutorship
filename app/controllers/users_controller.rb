# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show destroy]

  # GET /users
  def index
    @users = User.all
  end

  # GET /@login
  def show
  end

  # DELETE /@login
  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find_by_login(params[:login])
  end
end
