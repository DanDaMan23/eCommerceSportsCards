class Card < ApplicationRecord
  belongs_to :player
  belongs_to :team
  validates :price, :quantity, :player, :team, presence: true
  has_one_attached :image
end
