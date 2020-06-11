class PagesController < ApplicationController
  before_action :check_for_redirects, only: :show

  def show
    @page = Page.find_by_slug!(params[:slug])
  end

  private

  def check_for_redirects
    if params[:slug] && r = (Redirect.find_by_from_path("/#{params[:slug]}/") || Redirect.find_by_from_path("/#{params[:slug]}"))
      r.increment! :clicks
      redirect_to r.to_url, status: :moved_permanently
    end
  end
end
