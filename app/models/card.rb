class Card < ApplicationRecord
  belongs_to :player
  belongs_to :team
  has_many :card_orders
  validates :price, :quantity, :brand, :player, :team, presence: true
  has_one_attached :image
end
