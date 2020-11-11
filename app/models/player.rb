class Player < ApplicationRecord
    has_many :cards
    has_many :teams, :through => :cards
end
