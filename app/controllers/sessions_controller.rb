class SessionsController < ApplicationController
  def create
    @user_info = request.env["omniauth.auth"]
  end
  def destroy
  end
end
