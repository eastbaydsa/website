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
#  featured       :boolean          default(TRUE), not null
#
# Indexes
#
#  index_blog_posts_on_author_id  (author_id)
#  index_blog_posts_on_slug       (slug) UNIQUE
#

class BlogPost < ApplicationRecord
  include HasSlug

  scope :listed, -> { where(listed: true).order('posted_at DESC') }
  scope :homepage, -> { where(listed: true, featured: true).order('posted_at DESC') }

  belongs_to :author, class_name: 'Admin'
  alias_attribute :to_param, :slug
end
