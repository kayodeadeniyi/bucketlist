require 'test_helper'

class Api::V1::UsersControllerTest < ActionController::TestCase

  def setup
    @user = User.create(name: "kay", email: "kay@yahoo.com", password: "kayode", login: true)
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(@user.auth_token)
  end

  test "create can create a user" do
    assert_difference("User.count", 1) do
      create_params = { name: "Iyke", email: "iyk@yahoo.com", password: "password123" }

      post :create, create_params
      user_response = JSON.parse(response.body)

      assert_equal "Iyke", user_response["user"]["name"]
      assert_equal "iyk@yahoo.com", user_response["user"]["email"]
      assert_equal true, user_response["user"]["auth_token"].present?
    end
  end

  test "show can show a specified user" do
    get :show

    user_response = JSON.parse(response.body)

    assert_equal "kay", user_response["user"]["name"]
    assert_equal "kay@yahoo.com", user_response["user"]["email"]
    assert_equal @user.auth_token, user_response["user"]["auth_token"]
  end

  test "update can update a specified user" do
    get :update, {name: "Chikody", email: "chiyk@yahoo.com"}

    user_response = JSON.parse(response.body)

    assert_equal 1, User.count
    assert_equal "Chikody", user_response["user"]["name"]
    assert_equal "chiyk@yahoo.com", user_response["user"]["email"]
  end

  test "delete can delete a specified user" do
    get :destroy

    user_response = JSON.parse(response.body)

    assert_equal 0, User.count
    assert_equal "success", user_response["status"]
    assert_equal "User deleted successfully", user_response["body"]
  end

end
