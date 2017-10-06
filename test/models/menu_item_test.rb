# == Schema Information
#
# Table name: menu_items
#
#  id         :integer          not null, primary key
#  label      :string
#  slug       :string
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class MenuItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
