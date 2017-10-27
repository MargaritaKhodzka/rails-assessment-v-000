class CategorySerializer < ActiveModel::Serializer
  attributes :id, :title, :climate, :must_have_items
  has_many :destinations, serializer: DestinationCategorySerializer
end
