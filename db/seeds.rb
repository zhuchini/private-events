# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.delete_all
Event.delete_all

User.create!(name:"jamcry", email:"jamcry@hotmail.com",
             password:"foobar", password_confirmation:"foobar")
User.create!(name:"john", email:"john@doe.com",
             password:"foobar", password_confirmation:"foobar")
User.create!(name: "dirk", email:"gent@ly.com",
             password:"foobar", password_confirmation:"foobar")

50.times do |n|
  User.create!(name: Faker::Name.unique.name,
               email: Faker::Internet.email,
               password: "foobar",
               password_confirmation: "foobar")
end


user_id_range = ((User.first.id)..(User.last.id))
50.times do |n|
  e = Event.create!(title: Faker::Book.title,
                    creator: User.find(rand(user_id_range)),
                    location: Faker::University.name,
                    date: Faker::Time.between(10.days.ago, 40.days.from_now, :all))
  rand(user_id_range).times {e.attendees << User.find(rand(user_id_range))}
end
