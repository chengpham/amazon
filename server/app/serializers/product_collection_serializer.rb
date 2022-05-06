class ProductCollectionSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :price, :tag_names
end
