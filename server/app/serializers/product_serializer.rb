class ProductSerializer < ActiveModel::Serializer
  attributes( :id, :title, :description, :price, :sale_price, :created_at, :updated_at )
  
  belongs_to :user, key: :seller
  class UserSerializer < ActiveModel::Serializer
    attributes :id, :first_name, :last_name, :email, :full_name
  end

  has_many :reviews
  class ReviewSerializer < ActiveModel::Serializer
    attributes :id, :body, :rating, :like_count, :vote_count, :reviewer
    def like_count
      object.likes.count
    end
    def vote_count
      object.votes.count
    end
    def reviewer
      object.user.full_name
    end
  end
end
