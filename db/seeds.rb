# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.destroy_all
Bucketlist.destroy_all
Item.destroy_all

10.times do |n|
  user = User.create(name: "Jeff#{n+1}", password: "adeniyi", email: "kay@yahoo.com")
  bucketlist = Bucketlist.create(name: "Doit#{n+1}", user_id: user.id)
  Item.create(name: "Spoon#{n+1}", bucketlist_id: bucketlist.id)
end
