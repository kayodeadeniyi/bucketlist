require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user is valid with a name" do
    user = User.new(name: "Kay", email: "kay@yahoo.com", password: "kayode")

    assert user.valid?

    user.save

    assert_equal 1, User.count
  end

  test "user is not valid without a name" do
    user = User.new(name: nil, email: "kay@yahoo.com", password: "kayode")

    assert user.invalid?
    refute user.valid?
  end

  test "user is valid with an email" do
    user = User.new(name: "Kay", email: "kay@yahoo.com", password: "kayode")

    assert user.valid?

    user.save

    assert_equal 1, User.count
  end

  test "user is not valid without an email" do
    user = User.new(name: "Kay", email: nil, password: "kayode")

    assert user.invalid?
    refute user.valid?
  end

  test "user is valid with a password" do
    user = User.new(name: "Kay", email: "kay@yahoo.com", password: "kayode")

    assert user.valid?

    user.save

    assert_equal 1, User.count
  end

  test "user is not valid without a password" do
    user = User.new(name: "Kay", email: "kay@yahoo.com", password: nil)

    assert user.invalid?
    refute user.valid?
  end

  test "a user can have many bucketlists" do
    user = User.create(name: "Jeff", email: "kay@yahoo.com", password: "kayode")
    bucketlist1 = Bucketlist.create(name: "Ikem's bucketlist")
    bucketlist2 = Bucketlist.create(name: "Stephen bucketlist")

    user.bucketlists << bucketlist1
    user.bucketlists << bucketlist2

    assert_equal 2, user.bucketlists.count
  end

  test "a bucketlist can have many Items, another way with arrays" do
    user = User.create(name: "Jeff",email: "kay@yahoo.com", password: "kayode")
    bucketlist1 = Bucketlist.create(name: "Ikem's bucketlist")
    bucketlist2 = Bucketlist.create(name: "Stephen bucketlist")

    user.bucketlists = [bucketlist1, bucketlist2]

    assert_equal 2, user.bucketlists.count
  end
end
