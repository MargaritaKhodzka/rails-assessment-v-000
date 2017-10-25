class UserSerializer < ActiveModel::Serializer
  attributes :id, :email
  has_many :destinations
  has_many :categories
end
