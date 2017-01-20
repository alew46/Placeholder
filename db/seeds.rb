# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

10.times do
  User.create!(
    email: Faker::Internet.email,
    password: Faker::Internet.password,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
end

User.create!(
  email: "test@user.com",
  password: "helloworld",
  first_name: "Test",
  last_name: "User"
)

users = User.all

15.times do(
  Topic.create!(
    title: Faker::Lorem.word,
    user: users.sample
  )
end

topics = Topic.all

50.times do
  Bookmark.create!(
    url: Faker::Internet.url,
    topic: users.sample
  )
end

puts "Seeding complete."
puts "#{User.count} users created."
puts "#{Topic.count} topics created."
puts "#{Bookmark.count} bookmarks created."
