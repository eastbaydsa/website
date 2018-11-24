require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @events_uri = "/events/"
  end

  test "index" do
    get @events_uri
    assert_response :success
  end
end
