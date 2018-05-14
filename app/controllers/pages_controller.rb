class PagesController < ApplicationController
  before_action :check_for_redirects, only: :show

  def home
    @home = Home.first
    raise 'Please create a homepage object first' unless @home

    @event = Event.query(Date.today, nil, 3).first
  end

  def show
    @page = Page.find_by_slug!(params[:slug])
  end

private

  def check_for_redirects
    if params[:slug] and r = Redirect.find_by_from_path("/#{params[:slug]}")
      r.increment! :clicks
      redirect_to r.to_url
    end
  end
end
