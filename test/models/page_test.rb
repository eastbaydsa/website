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

require 'test_helper'

class PageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
