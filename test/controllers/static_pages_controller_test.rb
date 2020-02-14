require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_path
    assert_template "static_pages/index"
    assert_response :success
end
