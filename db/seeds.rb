# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(email: 'operator1@example.com', password: 'password', role: 'operator')
puts 'Operator 1 account: operator1@example.com/password'
User.create(email: 'operator2@example.com', password: 'password', role: 'operator')
puts 'Operator 2 account: operator2@example.com/password'
User.create(email: 'operator3@example.com', password: 'password', role: 'operator')
puts 'Operator 3 account: operator3@example.com/password'
