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

class MenuItem < ApplicationRecord
  acts_as_list top_of_list: 0

  default_scope { order(position: :asc) }
end
