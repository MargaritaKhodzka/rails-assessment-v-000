class VisitSerializer < ActiveModel::Serializer
  attributes :id
  belongs_to :destination
end
