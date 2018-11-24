# == Schema Information
#
# Table name: blog_posts
#
#  id         :integer          not null, primary key
#  title      :text
#  content    :text
#  posted_at  :datetime
#  slug       :string           not null
#  author_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class BlogPostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @blogs_uri = "/news/"
  end

  test "index" do
    get @blogs_uri
    assert_response :success
  end

  test "show" do
    post = blog_posts(:test_blog_post)
    get "#{@blogs_uri}/#{post.posted_at.year}/#{post.posted_at.month}/#{post.posted_at.day}/#{post.slug}/"
    assert_response :success
  end
end
