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

class Home < ApplicationRecord
  belongs_to :featured_page_1, class_name: 'Page'
  belongs_to :featured_page_2, class_name: 'Page'
end
