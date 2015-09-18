require 'test_helper'
require 'pry'
class BucketlistTest < ActiveSupport::TestCase
  test "a bucketlist is valid with a name" do
    bucketlist_with_a_name = Bucketlist.create(name: "Kay", user_id: 2)

    assert bucketlist_with_a_name.valid?
    refute bucketlist_with_a_name.invalid?
  end

  test "a bucketlist is not valid without a name" do
    bucketlist_without_a_name = Bucketlist.create(user_id: 2)

    assert bucketlist_without_a_name.invalid?
    refute bucketlist_without_a_name.valid?
  end

  test "a bucketlist is valid with a user" do
    bucketlist_with_a_user = Bucketlist.create(name: "Kay", user_id: 2)

    assert bucketlist_with_a_user.valid?
    refute bucketlist_with_a_user.invalid?
  end

  test "a bucketlist is not valid without a user" do
    bucketlist_without_a_user = Bucketlist.create(name: "Kay")

    assert bucketlist_without_a_user.invalid?
    refute bucketlist_without_a_user.valid?
  end

  test "a bucketlist can have many Items" do
    bucketlist = Bucketlist.create(name: "Jeff", user_id: 1)
    bucketlist_Item1 = Item.create(name: "Visit Ikem", done: true)
    bucketlist_Item2 = Item.create(name: "Join Video call", done: true)

    bucketlist.items << bucketlist_Item1
    bucketlist.items << bucketlist_Item2

    assert_equal 2, bucketlist.items.count
  end

  test "a Bucketlist can have many Items, another way with arrays" do
    bucketlist = Bucketlist.create(name: "Jeff", user_id: 1)
    bucketlist_Item1 = Item.create(name: "Visit Ikem", done: true)
    bucketlist_Item2 = Item.create(name: "Visit Ikem", done: false)

    bucketlist.items = [bucketlist_Item1, bucketlist_Item2]

    assert_equal 2, bucketlist.items.count
  end

end
