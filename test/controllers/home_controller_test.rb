require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_url
    assert_response :success
  end

  test "should get dashboard" do
    get dashboard_url
    assert_redirected_to new_session_url

    User.create!(email_address: "foo@bar.com", password: "password")
    post session_url, params: { email_address: "foo@bar.com", password: "password" }
    assert_redirected_to dashboard_url
    follow_redirect!
    assert_response :success

    delete session_url
    get dashboard_url
    assert_redirected_to new_session_url
  end
end
