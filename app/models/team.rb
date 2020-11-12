class Team < ApplicationRecord
    has_many :cards
    has_many :players, :through => :cards
    validates :name, :city, presence: true 
end
