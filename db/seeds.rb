# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Card.delete_all
Player.delete_all
Team.delete_all

def create_players(number_of_players)
  number_of_players.times do
    player = Faker::Sports::Basketball.unique.player
    Player.create(name: player)
  end
end

def create_teams(number_of_team)
  number_of_team.times do
    team = Faker::Sports::Basketball.unique.team
    team = team.split(' ')
    Team.create(name: team[-1], city: team[0])
  end
end

create_players(20)
create_teams(30)

puts "Players created: #{Player.count}"
puts "Teams created #{Team.count}"
puts "Cards created: #{Card.count}"

if Rails.env.development?
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
end

# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?