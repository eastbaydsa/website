class BlogPostsController < ApplicationController

  def index
    @posts = BlogPost.all.order('posted_at DESC')
  end

  def show
    @post = BlogPost.find_by_slug!(params[:slug])
  end

end
