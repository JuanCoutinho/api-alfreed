require "test_helper"

class ApprovalControllerTest < ActionDispatch::IntegrationTest
  test "should get waiting_approval" do
    get approval_waiting_approval_url
    assert_response :success
  end
end
