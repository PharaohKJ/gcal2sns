# coding: utf-8

class SessionsController < ApplicationController
  def create
    @user_info = request.env['omniauth.auth']
    @user = User.where(uid: @user_info.uid).first_or_create
    @user.name = @user_info.info.name
    @user.uid  = @user_info.uid
    @user.picture = @user_info.info.picture
    @user.email = @user_info.info.email
    @user.token = @user_info.credentials.token
    @user.refresh_token = @user_info.credentials.refresh_token
    @user.save!

    session[:user_uid] = @user.uid
  end

  def destroy
  end
end
