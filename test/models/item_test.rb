require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  test "item is valid with name and item status" do
    item = Item.new(name: "Kay", done: true)

    assert item.valid?

    item.save

    assert_equal 1, Item.count
  end

  test "item is not valid without a name" do
    item = Item.new(name: nil,done: true)

    assert item.invalid?
    refute item.valid?
  end

  test "item is valid without an item status" do
    item = Item.new(name: "Kay")

    assert item.valid?
  end

  test "item belongs to a bucketlist" do
    bucketlist = Bucketlist.create(name: "jeff")
    item = Item.create(name: "Kay", done: true)

    item.bucketlist = bucketlist

    refute item.bucketlist.blank?
    assert_equal "jeff", item.bucketlist.name
  end
end
