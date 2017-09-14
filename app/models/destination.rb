class Destination < ApplicationRecord
  belongs_to :user
  has_many :destination_categories
  has_many :categories, through: :destination_categories

  validates :name, :description, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validates :description, length: { maximum: 500, too_long: "%{count} characters is the maximum allowed" }

   def categories_attributes=(categories_attributes)
     categories_attributes.values.each do |category_attribute|
       category = Category.find_or_create_by(category_attribute)
       categories << category if category.persisted?
     end
   end

end
