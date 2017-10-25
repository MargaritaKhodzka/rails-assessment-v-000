class DestinationSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :country, :best_season_to_visit, :visited
  has_many :categories, serializer: DestinationCategorySerializer
end
