class EventsController < ApplicationController
  before_action :require_nationbuilder_slug

  def index
    @start_date = if params[:start_date]
      Date.parse(params[:start_date])
    else
      Date.today.beginning_of_month
    end

    end_date = @start_date.end_of_month

    @events = Event.query(@start_date.to_s, end_date.to_s)

    if @start_date == Date.today.beginning_of_month
      # viewing current month, setup an array of only upcoming events
      @upcoming_events = @events.select{|e| e.start_time.future? }
    end

    render layout: 'full_width'
  end

  def show
    @event = Event.find(params[:id])
  end
end
