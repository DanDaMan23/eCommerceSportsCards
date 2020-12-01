class Order < ApplicationRecord
  belongs_to :customer
  has_many :card_orders
end
