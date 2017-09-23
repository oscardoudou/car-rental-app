require 'test_helper'

class AdminlControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get adminl_index_url
    assert_response :success
  end

end
