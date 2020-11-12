class Card < ApplicationRecord
  belongs_to :player
  belongs_to :team

  has_one_attached :image
end
