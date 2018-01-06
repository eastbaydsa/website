# == Schema Information
#
# Table name: pages
#
#  id           :integer          not null, primary key
#  title        :text
#  content      :text
#  slug         :string           not null
#  show_in_menu :boolean
#  parent_id    :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  subtitle     :text
#
# Indexes
#
#  index_pages_on_slug  (slug) UNIQUE
#

class Page < ApplicationRecord
  include HasSlug

  has_many :subpages, class_name: 'Page', foreign_key: :parent_id
  belongs_to :parent, class_name: 'Page', optional: true

  alias_attribute :to_param, :slug
end
