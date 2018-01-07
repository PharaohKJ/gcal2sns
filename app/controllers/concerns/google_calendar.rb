require 'google/api_client/client_secrets.rb'

module GoogleCalendar
  extend ActiveSupport::Concern

  def calendar_service(user)
    return nil if user.nil?
    return @cal_service unless @cal_service.nil?
    begin
      secrets = Google::APIClient::ClientSecrets.new(
        web: {
          access_token:  user.token,
          refresh_token: user.refresh_token,
          client_id:     ENV['GOOGLE_CLIENT_ID'],
          client_secret: ENV['GOOGLE_SECRET']
        }
      )

      @cal_service = Google::Apis::CalendarV3::CalendarService.new
      @cal_service.authorization = secrets.to_authorization
      @cal_service
    rescue e
      logger.error(e.to_s)
      nil
    end
  end

  def calendar_service_by_session
    return @cal_service unless @cal_service.nil?
    user = User.find_by(uid: session[:user_uid])
    calendar_service(user)
  end
end
