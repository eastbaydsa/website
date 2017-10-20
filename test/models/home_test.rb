# == Schema Information
#
# Table name: homes
#
#  id                 :integer          not null, primary key
#  intro              :text
#  featured_page_1_id :integer
#  featured_page_2_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'test_helper'

class HomeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
