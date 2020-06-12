class HomeController < ApplicationController
  before_action :check_for_redirects, only: :show

  def index
    @events = Event.query(limit: 6)
    @posts = BlogPost.homepage.limit(3)
    @highlighted_campaigns = Page.highlighted_campaigns

    render 'index', layout: 'full_width'
  end
end
