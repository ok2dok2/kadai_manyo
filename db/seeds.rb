
10.times do |n|
  User.create!(
    username: "admin#{n + 1}",
    email: "admin#{n + 1}@ggmail.com",
    password: 'pass',
    password_confirmation: 'pass',
    admin: 1
  )
end

User.all.each do |user|
  user.tasks.create(
    name: 'テスト2',
    detail: 'テスト2',
    date: "2023-07-04",
    status: 2,
    priority: 1 
  )
end

10.times do |n|
  Label.create(
    title: "label#{n + 1}"  
  )
end



# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
