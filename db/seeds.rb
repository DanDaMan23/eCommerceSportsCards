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

def create_cards(number_of_cards)
  card_url = "https://nba-players.herokuapp.com/players-stats"
  response = RestClient.get(card_url)

  cards = JSON.parse(response)

  (0..number_of_cards).each do |i|
    player = Player.find_or_create_by(name: "#{cards[i]["name"]}")
    team = Team.where("name LIKE '#{cards[i]["team_name"].split(' ')[-1]}'")
    Card.create(price: 10, quantity: 2, brand: "No Name", player: player, team: team[0])
  end

end

create_players(20)
create_teams
create_cards(110)

puts "Players created: #{Player.count}"
puts "Teams created #{Team.count}"
puts "Cards created: #{Card.count}"

if Rails.env.development?
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
end

# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?