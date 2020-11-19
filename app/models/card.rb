class Card < ApplicationRecord
  belongs_to :player
  belongs_to :team
  validates :price, :quantity, :brand, :player, :team, presence: true
  has_one_attached :image
end
