class Category < ApplicationRecord
  belongs_to :user
  has_many :destination_categories
  has_many :destinations, through: :destination_categories
  
  validates :title, presence: true
  validates :title, uniqueness: { case_sensitive: false }
end
