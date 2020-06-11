class HomeController < ApplicationController
  before_action :check_for_redirects, only: :show

  def index
    @events = Event.query(limit: 6)
    @posts = BlogPost.homepage.limit(3)
    @highlighted_campaigns = Page.highlighted_campaigns.order(order: :asc).limit(3)
    @show_campaigns_homepage_section = Flipper.enabled?(:campaigns_homepage_section)
    @show_majority_homepage_section = Flipper.enabled?(:majority_homepage_section)

    if Setting.homepage_hardcoded
      render 'index', layout: 'full_width'
    else
      @page = Page.where(slug: 'home').first
      @page ||= Page.first
      render 'pages/show'
    end
  end
end
