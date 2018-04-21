# == Schema Information
#
# Table name: redirects
#
#  id         :integer          not null, primary key
#  from_path  :string
#  to_url     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  clicks     :integer          default(0)
#

class Redirect < ApplicationRecord
  validates :from_path, presence: true, format: { with: /\A\/.*/i, message: 'must begin with "/"'}, uniqueness: true
  validates :to_url, presence: true, format: { with: /\A(\/|http).*/i, message: 'must begin with "/" or "http"'}
end
