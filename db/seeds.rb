require 'open-uri'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


unless Admin.count == 1 
  Admin.create!(email: 'admin@example.com', password: '123456', password_confirmation: '123456')
end

20.times do
  post = Post.create(
    title: Faker::Hipster.sentence,
    body: Faker::Hipster.paragraphs(number: 20).join,
    publish_date: Faker::Date.between(from: '2023-01-01', to: '2023-02-28')
  )
  post.image.attach(filename: 'file.jpg', io: URI.open(Faker::LoremFlickr.image))
end