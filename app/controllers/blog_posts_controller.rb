class BlogPostsController < ApplicationController

  def index
    @posts = BlogPost.listed.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @post = BlogPost.find_by_slug!(params[:slug])
  end

end
