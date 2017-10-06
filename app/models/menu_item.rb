# == Schema Information
#
# Table name: menu_items
#
#  id         :integer          not null, primary key
#  label      :string
#  slug       :string
#  order      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class MenuItem < ApplicationRecord
end
