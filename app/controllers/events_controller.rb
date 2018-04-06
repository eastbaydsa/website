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

    @events = Event.query(@start_date.to_s, end_date.to_s)
  end

  def show
    @event = Event.find(params[:id])
    @event.description = '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>'
    @event.name = "May Day Meetup"
    @event.address = {
      'address1' => '1901 Myrtle St.',
      'address2' => 'Apt 2',
      'address3' => nil,
      'city' => 'Oakland',
      'state' => 'CA',
      'zip' => '94607'
    }
  end

end
