# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.delete_all
Event.delete_all

User.create!(name:"Henry", email:"henry@hotmail.com")
User.create!(name:"John", email:"john@doe.com")
User.create!(name: "Kirk", email:"kirk@ly.com")

50.times do |n|
  User.create!(name: Faker::Name.unique.name,
               email: Faker::Internet.email)
end

User.all.each do |user|
  all_others = User.where.not('id = ?', user.id)
  5.times do
    date = Faker::Time.between(1.year.ago, 1.year.from_now)
    event = user.created_events.create!(title: Faker::Lorem.sentence,
                                        location: Faker::Address.full_address,
                                        date: date)
    puts "=====#{event.title}====="
    all_others.each do |other_user|
        random_created_at = (date > Time.now ? Faker::Time.between(2.months.ago, Time.now) : Faker::Time.between(date - 5.months, date))
        random_attending = [true, false, nil].sample
        event.attendances.create!(attendee: other_user,
                                  attendance: random_attending,
                                  date: random_created_at)
    end
  end
end
