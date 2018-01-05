class EventsController < ApplicationController
  before_action do
    raise 'You must set NATION_SITE_SLUG in your .env to access this feature.' unless ENV['NATION_SITE_SLUG']
  end

  def index
    @start_date = if params[:start_date]
      Date.parse(params[:start_date])
    else
      Date.today.beginning_of_month
    end

    end_date = @start_date.end_of_month

    @events = nation_builder_client.call(:events, :index, {
      site_slug: ENV['NATION_SITE_SLUG'],
      starting: @start_date.to_s,
      until: end_date.to_s,
      limit: 1000,
    })["results"]
      .select{ |e| e["published_at"] != nil }
      .map{ |e| Event.new(e) }
  end

  def show
    @event = Event.find(params[:id])
  end

end
