require 'rest-client'

Card.delete_all
Player.delete_all
Team.delete_all

def create_players(number_of_players)
  number_of_players.times do
    player = Faker::Sports::Basketball.unique.player
    Player.create(name: player)
  end
end

def create_teams
  team_url = "https://www.balldontlie.io/api/v1/teams"
  response = RestClient.get(team_url)

  parsed = JSON.parse(response)
  teams = parsed["data"]

  teams.each do |team|
    Team.create(name: team["name"], city: team["city"])
  end

end

create_players(20)
create_teams

puts "Players created: #{Player.count}"
puts "Teams created #{Team.count}"
puts "Cards created: #{Card.count}"

if Rails.env.development?
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
end

# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?