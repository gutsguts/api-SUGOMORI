# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# http://localhost:3000/api/v1/auth/sign_in

User.create!(name: 'Example AdminUser',
             email: 'example_admin-1@example.com',
             uid: 'example_admin-1@example.com',
             password: 'password',
             password_confirmation: 'password',
             admin: true)

99.times do |n|
  # name  = Faker::Name.name + (n + 1)
  name = Faker::Name.name

  email = "example-#{n + 2}@example.com"
  # uid = "example-#{n + 1}@example.com"

  password = 'password'
  User.create!(name: name,
               email: email,
               uid: email,
               password: password,
               password_confirmation: password)
end

# 20.times do |n|
#   User.create(name: "#{n + 1}-name", email: "#{n + 1}@example.com")
# end

20.times do |n|
  Picpost.create(content: "#{n + 1}-post")
end

# User.create!(
#   [
#     {
#       name: 'Mary'
#     },
#     {
#       name: 'Alice'
#     },
#     {
#       name: 'John'
#     }
#   ]
# )

# Post.create!(
#   [
#     {
#       content: '勉強'
#     },
#     {
#       content: '映画鑑賞'
#     },
#     {
#       content: '掃除'
#     }
#   ]
# )
