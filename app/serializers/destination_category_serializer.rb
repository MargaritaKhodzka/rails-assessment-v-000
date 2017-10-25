class DestinationCategorySerializer < ActiveModel::Serializer
  attributes :id, :destination_id, :category_id
  belongs_to :destination
  belongs_to :category
end
