require "test_helper"

class ReportControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get report_list_url
    assert_response :success
  end
end
