require 'test_helper'

class SadminlControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sadminl_index_url
    assert_response :success
  end

end
