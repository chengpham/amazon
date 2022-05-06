class NewsArticle < ApplicationRecord
    belongs_to :user
    before_save :capitalize_title
    validates :title, presence: true, uniqueness:true
    validates :description, presence: true
    validate :publish_date_after_created_at_date

    def publish
        self.published_at ||= Date.current
    end
    private
    def capitalize_title
        self.title.capitalize!
    end
    def publish_date_after_created_at_date
        if published_at < created_at
            errors.add(:published_at, "can't be before created at date")
        end
    end
end
