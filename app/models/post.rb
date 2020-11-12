class Post < ApplicationRecord
    validates :title, :details, presence: true
end
