# == Schema Information
#
# Table name: blog_posts
#
#  id             :integer          not null, primary key
#  title          :text
#  content        :text
#  posted_at      :datetime
#  slug           :string           not null
#  author_id      :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  featured_image :string
#  listed         :boolean          default(TRUE)
#  meta_title     :string
#  meta_desc      :string
#
# Indexes
#
#  index_blog_posts_on_author_id  (author_id)
#  index_blog_posts_on_slug       (slug) UNIQUE
#

require 'test_helper'

class BlogPostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
