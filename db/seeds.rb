# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do |n|
  name = "Example User" + n.to_s
  events_name = "Example Events" + n.to_s

  user = User.create!(name: Faker::Name.unique.name, email: Faker::Internet.email)
  if n <= 6
    event = user.created_events.create!(title: Faker::Lorem.sentence, location: Faker::Address.full_address, date: Date.today)
  else 
    event = user.created_events.create!(title: Faker::Lorem.sentence, location: Faker::Address.full_address, date: "13 Feb 2020")
  end
  event.attendances.create(attendee_id: user.id)
end
