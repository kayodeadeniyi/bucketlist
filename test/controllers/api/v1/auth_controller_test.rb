require 'test_helper'

class Api::V1::AuthControllerTest < ActionController::TestCase
  test "login can log users in" do
    @user = User.create(name: "kay", email: "kay@yahoo.com", password: "kayode", login: true)
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(@user.auth_token)

    login_params = { email: @user.email, password: @user.password }

    get :login, login_params
    login_response = JSON.parse(response.body)

    assert_equal @user.name, login_response["user"]["name"]
    assert_equal @user.email, login_response["user"]["email"]
    assert_equal @user.auth_token, login_response["user"]["auth_token"]
  end

  test "login can log users in without token" do
    @user = User.create(name: "kay", email: "kay@yahoo.com", password: "kayode", login: true)

    login_params = { email: @user.email, password: @user.password }

    get :login, login_params
    login_response = JSON.parse(response.body)

    assert_equal @user.name, login_response["user"]["name"]
    assert_equal @user.email, login_response["user"]["email"]
  end

  test "login cannot log users in without password" do
    @user = User.create(name: "kay", email: "kay@yahoo.com", password: "kayode", login: true)

    login_params = { email: @user.email, password: "" }

    get :login, login_params
    login_response = JSON.parse(response.body)

    assert_equal 200, response.status
    assert_equal "failure", login_response['status']
    assert_equal "Invalid login credential", login_response['body']
  end

  test "logout can log users out" do
    @user = User.create(name: "kay", email: "kay@yahoo.com", password: "kayode", login: true)
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(@user.auth_token)

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

  test "logout cannot log users out without a token" do
    @user = User.create(name: "kay", email: "kay@yahoo.com", password: "kayode", login: true)

    get :logout

    assert_equal 401, response.status
    assert_equal "Bad Credentials", response.body
  end

  test "logout cannot log users out without being logged in" do
    @user = User.create(name: "kay", email: "kay@yahoo.com", password: "kayode", login: false)
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(@user.auth_token)

    get :logout

    assert_equal 401, response.status
    assert_equal "Token Expired", response.body
  end

end
