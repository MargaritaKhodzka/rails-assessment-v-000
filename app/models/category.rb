class Category < ApplicationRecord
  has_many :destination_categories
  has_many :destinations, through: :destination_categories

  validates :title, presence: true
  validates :title, uniqueness: true
  validates :climate, presence: true
end
