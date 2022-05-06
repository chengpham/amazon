class Product < ApplicationRecord

    after_initialize :set_defaults, :set_default_sale_price
    before_save :capitalize_title
    before_destroy :log_delete_details

    has_many :reviews, dependent: :destroy 
    belongs_to :user, optional: true
    
    has_many :favourites, dependent: :destroy
    has_many :favouriters, through: :favourites, source: :user

    has_many :taggings, dependent: :destroy
    has_many :tags, through: :taggings
    
    validates :title, presence: {message: 'must be provided'}, uniqueness: true, exclusion: {in: ['apple', 'microsoft', 'sony'], message: "Value is reserved. Please use a different title"}
    validates :description, presence: true, length:{minimum: 10}
    validates :price, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 1000}
    validate :sale_price_less_than_price
    
    # Product.where("price > 50 AND price < 100").order(title: :ASC).limit(10) 


    scope :search, -> (query) {where("title ILIKE ? OR description ILIKE ?", "%#{query}%", "%#{query}%")}

    def increment_hit_count
        new_hit_count = self.hit_count += 1
        update({hit_count: new_hit_count})
    end
    def tag_names
        self.tags.map(&:name).join(', ')
    end
    def tag_names=(rhs)
        self.tags=rhs.strip.split(/\s*,\s*/).map do|tag_name|
            Tag.find_or_initialize_by(name: tag_name)
        end
    end
    
    private
    def capitalize_title
        self.title.capitalize!
    end
    def set_defaults
        self.price ||=1
    end
    def set_default_sale_price
        self.sale_price ||= self.price
    end

    def sale_price_less_than_price
        if self.sale_price > self.price
            errors.add(:sale_price, "sale_price: #{self.sale_price} must be lower than price: #{self.price}")
        end
    end
    def log_delete_details
        puts "Product #{self.id} is about to be deleted"
    end
    def self.all_with_voters_counts
        self.left_outer_joins(:reviews)
            .select("product.*","Count(reviews.voters.*) AS voters_count")
            .group('product.id')
    end
    
end

