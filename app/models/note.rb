class Note < ApplicationRecord

  belongs_to :destination
  belongs_to :user

  validates :user, presence: true
  validates :destination, presence: true
  validates_presence_of :content

end
