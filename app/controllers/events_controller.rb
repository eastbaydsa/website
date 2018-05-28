class EventsController < ApplicationController
  before_action :require_nationbuilder_slug

  def index
    @start_date = if params[:start_date]
      Date.parse(params[:start_date])
    else
      Date.today.beginning_of_month
    end

    end_date = @start_date.end_of_month

    @events = Event.query((@start_date - 7.days).to_s, (end_date + 7.days).to_s)


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
