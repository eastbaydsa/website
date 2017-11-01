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
# Indexes
#
#  index_blog_posts_on_author_id  (author_id)
#  index_blog_posts_on_slug       (slug) UNIQUE
#

class BlogPost < ApplicationRecord
  include HasSlug

  belongs_to :author, class_name: 'Admin'
  alias_attribute :to_param, :slug
end
