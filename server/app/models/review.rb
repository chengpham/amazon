class Review < ApplicationRecord
    belongs_to :product
    belongs_to :user, optional: true

    has_many :likes, dependent: :destroy
    has_many :likers, through: :likes, source: :review
    has_many :votes, dependent: :destroy
    has_many :voters, through: :votes, source: :review


    validates :rating, numericality: {greater_than_or_equal_to: 1, less_than_or_equal_to: 5}
end
