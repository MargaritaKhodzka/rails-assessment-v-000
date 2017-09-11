class Destination < ApplicationRecord
  belongs_to :user
  has_many :categories

  validates :name, :description, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validates :description, length: { maximum: 500, too_long: "%{count} characters is the maximum allowed" }
end
