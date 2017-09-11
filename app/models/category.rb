class Category < ApplicationRecord
  belongs_to :description
  validates :title, presence: true
  validates :title, uniqueness: { case_sensitive: false }
end
