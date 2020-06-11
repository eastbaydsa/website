class HomeController < ApplicationController
  before_action :check_for_redirects, only: :show

  def index
    @events = Event.query(limit: 6)
    @posts = BlogPost.homepage.limit(3)

    @show_campaigns_homepage_section = Flipper.enabled?(:campaigns_homepage_section)
    @show_majority_homepage_section = Flipper.enabled?(:majority_homepage_section)

    if @show_campaigns_homepage_section
      @highlighted_campaigns = Page.highlighted_campaigns.order(order: :asc).limit(3)
    end

    render 'index', layout: 'full_width'
  end
end
