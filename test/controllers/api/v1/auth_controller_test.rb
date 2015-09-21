require 'test_helper'

class Api::V1::AuthControllerTest < ActionController::TestCase
  def setup
    @user = User.create(name: "kay", email: "kay@yahoo.com", password: "kayode", login: true)
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(@user.auth_token)
  end

  test "login can log users in" do
    login_params = { email: @user.email, password: @user.password }

    get :login, login_params
    login_response = JSON.parse(response.body)

    assert_equal @user.name, login_response["user"]["name"]
    assert_equal @user.email, login_response["user"]["email"]
    assert_equal @user.auth_token, login_response["user"]["auth_token"]
  end

  test "logout can log users out" do
    login_params = { email: @user.email, password: @user.password }

    get :login, login_params
    login_response = JSON.parse(response.body)

    assert_equal @user.name, login_response["user"]["name"]
    assert_equal @user.email, login_response["user"]["email"]
    assert_equal @user.auth_token, login_response["user"]["auth_token"]

    get :logout
    logout_response = JSON.parse(response.body)

    assert_equal "success", logout_response["status"]
    assert_equal "User logged out successfully", logout_response["body"]
  end

end
