class LogEventsController < ApplicationController
  def index
    @log_events = LogEvent.paginate :page => params[:page], :order => 'created_at DESC'
  end
end
