# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(
  name: "John Smith",
  email: "john@example.com",
  password: "1",
  password_confirmation: "1",
  activated: true,
  activated_at: Time.zone.now
)

99.times do |n|
  name = Faker::Name.name
  email = Faker::Internet.email
  password = Faker::Internet.password
  password_confirmation = password
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password_confirmation,
    activated: true,
    activated_at: Time.zone.now
  )
end
