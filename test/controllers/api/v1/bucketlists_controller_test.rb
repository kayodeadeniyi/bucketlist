require 'test_helper'

class Api::V1::BucketlistsControllerTest < ActionController::TestCase
  def setup
    @user = User.create(name: "kay", email: "kay@yahoo.com", password: "kayode", login: true)
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(@user.auth_token)
  end

  test "the index action returns back json of all bucketlists" do

    cent = Bucketlist.create(name: "Century", user_id: 2)
    kay = Bucketlist.create(name: "Kayode", user_id: 2)
    fattie = Bucketlist.create(name: "Fattie", user_id: 2)

    get :index
    bucketlists = JSON.parse(response.body)

    assert_equal 3, bucketlists["bucketlists"].count
    assert_equal cent.id, bucketlists["bucketlists"][0]['id']
    assert_equal cent.name, bucketlists["bucketlists"][0]['name']
    assert_equal kay.id, bucketlists["bucketlists"][1]['id']
    assert_equal kay.name, bucketlists["bucketlists"][1]['name']
    assert_equal fattie.id, bucketlists["bucketlists"][2]['id']
    assert_equal fattie.name, bucketlists["bucketlists"][2]['name']
  end

  test "create can create a bucketlist" do
    assert_difference("Bucketlist.count", 1) do
      create_params = { name: "Iyke" }

      post :create, create_params
      bucketlist = JSON.parse(response.body)

      assert_equal "Iyke", bucketlist["bucketlist"]["name"]
    end
  end

  test "show can show a specified bucketlist" do
    bucketlist = Bucketlist.create(name: "kidneys", user_id: @user.id)
    get :show, { id: bucketlist.id }

    bucketlist = JSON.parse(response.body)

    assert_equal 1, Bucketlist.count
    assert_equal "kidneys", bucketlist["bucketlist"]["name"]
  end

  test "update can update a specified bucketlist" do
    bucketlist = Bucketlist.create(name: "Nkem", user_id: @user.id)
    get :update, { id: bucketlist.id, name: "Kayode" }

    bucketlist = JSON.parse(response.body)

    assert_equal 1, Bucketlist.count
    assert_equal "Kayode", bucketlist["bucketlist"]["name"]
  end

  test "delete can delete a specified bucketlist" do
    bucketlist = Bucketlist.create(name: "Nkem", user_id: @user.id)
    get :destroy, { id: bucketlist.id }

    bucketlist = JSON.parse(response.body)

    assert_equal 0, Bucketlist.count
    assert_equal "success", bucketlist["status"]
    assert_equal "Bucketlist deleted successfully", bucketlist["body"]
  end

  test "add_item can add an item to a specified bucketlist" do
    bucketlist = Bucketlist.create(name: "Nkem", user_id: @user.id)
    get :add_item, { id: bucketlist.id, name: "hello", done: true }

    bucketlist_item = JSON.parse(response.body)

    assert_equal 1, Bucketlist.count
    assert_equal 1, bucketlist.items.count
    assert_equal "hello", bucketlist_item["item"]["name"]
    assert_equal true, bucketlist_item["item"]["done"]
  end

end
