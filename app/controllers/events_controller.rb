class EventsController < ApplicationController
  before_action :require_nationbuilder_slug

  def index
    @start_date = Date.parse(params[:start_date]) rescue nil
    @start_date ||= Date.today.beginning_of_month
    params[:start_date] = @start_date.to_s # simple_calendar gem reads from params
    
    end_date = @start_date.end_of_month
    # When blank, returns all events
    @tags = params[:tags] || []

    @events = Event.query(
      start_date: (@start_date - 7.days).to_s,
      end_date: (end_date + 7.days).to_s,
      tags: @tags
    )


    @upcoming_events = @events.select{|e|
      e.start_time > @start_date.to_time.beginning_of_day &&
      e.end_time < end_date.end_of_day &&
      (@start_date == Date.today.beginning_of_month ? e.start_time.future? : true)
    }

    render layout: 'full_width'
  end

  def show
    @event = Event.find(params[:id])
  end
end
