# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

20.times do |n|
  title = Faker::Games::Pokemon.name
  text = Faker::Quote.famous_last_words
  Post.create!(
    title: title,
    text: text
  )
end

User.create!(
  email: '1@1',
  password: '111111'
)

50.times do |n|
  content = Faker::Address.street_name
  Comment.create!(
    user_id: '1',
    post_id: rand(1..20),
    content: content
  )
end
