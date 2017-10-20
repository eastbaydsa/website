class PagesController < ApplicationController
  layout 'home', only: 'home'

  def home

    @home = Home.first
    raise 'Please create a homepage object first' unless @home

    @events = [] #Event.query(Date.today, nil, 4)
  end

  def show
    @page = Page.find_by_slug!(params[:slug])
  end

end
