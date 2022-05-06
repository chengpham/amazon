class User < ApplicationRecord
    has_many :products, dependent: :nullify
    has_many :reviews, dependent: :nullify
    has_many :news_articles, dependent: :nullify
    has_secure_password
    
    has_many :likes, dependent: :destroy
    has_many :liked_reviews, through: :likes, source: :review
    has_many :favourites, dependent: :destroy
    has_many :favoured_products, through: :favourites, source: :product
    has_many :votes, dependent: :destroy
    has_many :voted_reviews, through: :votes, source: :review

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true

    geocoded_by :location
    after_validation :geocode

    scope :search, -> (search_term) {where("first_name LIKE ? OR last_name LIKE ? OR email LIKE ?", "#{search_term}", "#{search_term}", "#{search_term}")}
    scope :not_john, lambda{where.not("first_name LIKE ? OR last_name LIKE ?", "%John%", "%John%")}
    scope :created_after, -> (date) {where("created_at < ?", "#{date}")}

    def full_name
        "#{self.first_name} #{self.last_name}".strip.titleize
    end

    # User.where(created_at: '2020-06-01'..'2020-07-31') 
end

