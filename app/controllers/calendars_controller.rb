class CalendarsController < ApplicationController
  include GoogleCalendar

  def show
    id = params[:id]
    service = calendar_service_by_session
    service.get_calendar(id) do |r, e|
      @result = r
      @err = e
    end
  end
end
