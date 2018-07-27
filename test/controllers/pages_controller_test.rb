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
#

require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pages_uri = "/"
  end

  test "home" do
    get @pages_uri
    assert_response :success
  end

  test "show" do
    get "#{@pages_uri}/#{pages(:test_page).slug}"
    assert_response :success
  end

  test "redirect" do
    Redirect.create!(from_path: "/foo", to_url: "/bar")
    get "/foo"
    assert_response 301
    assert_redirected_to "/bar"
  end
end
