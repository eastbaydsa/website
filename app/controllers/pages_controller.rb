class PagesController < ApplicationController
  before_action :check_for_redirects, only: :show

  def home
    @page = Page.where(slug: 'home').first
    @page ||= Page.first

    @events = Event.query(limit: 3)
    render :show
  end

  def show
    @page = Page.find_by_slug!(params[:slug])
  end

  private

  def check_for_redirects
    if params[:slug] && r = Redirect.find_by_from_path("/#{params[:slug]}")
      r.increment! :clicks
      redirect_to r.to_url
    end
  end
end
