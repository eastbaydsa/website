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
    @blogs_uri = "/blog"
  end

  test "index" do
    get @blogs_uri
    assert_response :success
  end

  test "show" do 
    get "#{@blogs_uri}/#{blog_posts(:test_blog_post).slug}"
    assert_response :success
  end
end
