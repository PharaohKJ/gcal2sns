# coding: utf-8

require 'google/api_client/client_secrets.rb'

class SessionsController < ApplicationController
  def create
    @user_info = request.env['omniauth.auth']
    user = User.new
    user.name = @user_info.info.name
    user.uid  = @user_info.uid
    user.token = @user_info.credentials.token
    user.picture = @user_info.info.picture
    user.email = @user_info.info.email
    user.save!

    p @user_info
    p @user_info.credentials

    secrets = Google::APIClient::ClientSecrets.new(
      web: {
        access_token:  @user_info.credentials.token,
        refresh_token: @user_info.credentials.refresh_token,
        client_id:     ENV['GOOGLE_CLIENT_ID'],
        client_secret: ENV['GOOGLE_SECRET']
      }
    )

    cal_service = Google::Apis::CalendarV3::CalendarService.new
    cal_service.authorization = secrets.to_authorization
    @calendar_list = cal_service.list_calendar_lists
    p @calendar_list
  end

  def destroy
  end
end
