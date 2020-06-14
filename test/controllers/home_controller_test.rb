require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get root_url
    assert_response :success
    assert_select "title", "SOKAGU"
  end
  
  test "should get about" do
    get about_url
    assert_response :success
    assert_select "title", "About | SOKAGU"
  end

end
