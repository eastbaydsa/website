class PagesController < ApplicationController
  before_action :check_for_redirects, only: :show

  def home
    @events = Event.query(limit: 3)
    @posts = BlogPost.homepage.limit(3)
    @highlighted_campaigns = Page.highlighted_campaigns.order(order: :asc).limit(3)
    @show_campaigns_homepage_section = Flipper.enabled?(:campaigns_homepage_section)
    @show_majority_homepage_section = Flipper.enabled?(:majority_homepage_section)

    if Setting.homepage_hardcoded
      render 'home', layout: 'full_width'
    else
      @page = Page.where(slug: 'home').first
      @page ||= Page.first
      render 'show'
    end
  end

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
