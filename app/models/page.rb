# == Schema Information
#
# Table name: pages
#
#  id                   :integer          not null, primary key
#  title                :text
#  content              :text
#  slug                 :string           not null
#  parent_id            :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  subtitle             :text
#  listed               :boolean          default(TRUE)
#  show_form            :boolean          default(FALSE), not null
#  form_tags            :string
#  background_image_url :string
#  meta_title           :string
#  meta_desc            :string
#  form_collect_phone   :boolean          default(FALSE), not null
#  order                :integer
#  homepage_campaign    :boolean
#  homepage_text        :text
#  homepage_color       :text
#
# Indexes
#
#  index_pages_on_order  (order) UNIQUE
#  index_pages_on_slug   (slug) UNIQUE
#

class Page < ApplicationRecord
  include HasSlug

  scope :listed,                -> { where(listed: true) }
  scope :highlighted_campaigns, -> { where(homepage_campaign: true).order(order: :asc) }

  has_many :subpages, class_name: 'Page', foreign_key: :parent_id
  belongs_to :parent, class_name: 'Page', optional: true

  validates :form_tags, presence: true, if: :show_form?

  alias_attribute :to_param, :slug

  def all_parents
    parents = []
    page = self
    while page.parent
      parents << page.parent
      page = page.parent
    end
    parents
  end

  def home?; slug == 'home'; end
end
