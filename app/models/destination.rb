class Destination < ApplicationRecord
  has_many :user_destinations
  has_many :users, through: :user_destinations
  has_many :destination_categories
  has_many :categories, through: :destination_categories

  validates :name, :description, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validates :description, length: { maximum: 500, too_long: "%{count} characters is the maximum allowed" }
end
