class TopController < ApplicationController
  include GoogleCalendar
  def index
    @user = User.find_by(uid: session[:user_uid])
    return if @user.nil?
    service = calendar_service_by_session
    @calendar_list = service.list_calendar_lists
  end
end
