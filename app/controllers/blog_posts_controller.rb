class BlogPostsController < ApplicationController

  def index
    @posts = BlogPost.all
  end

  def show
    @post = BlogPost.find_by_slug!(params[:slug])
  end

end
