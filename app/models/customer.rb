class Customer < ApplicationRecord
  belongs_to :province
  validates :address, :city, :first_name, :last_name, :country, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
