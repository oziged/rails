# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

10.times do
  name = Faker::Name.first_name
  surname = Faker::Name.last_name
  email = "#{name.downcase}_#{surname.downcase}@gmail.com"
  user = User.create(name: name, surname: surname, email: email, password: '1234Qq', password_confirmation: '1234Qq', was_online: DateTime.now)
  2.times do
    user.posts.create(title: BetterLorem.w(3, true, true), body: BetterLorem.p(2, true, true))
  end
end

