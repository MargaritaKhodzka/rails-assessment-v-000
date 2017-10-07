class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  has_many :users_destinations
  has_many :destinations, through: :users_destinations

  has_many :categories, through: :destinations

  validates :email, presence: true
  validates :email, uniqueness: true
  validates :password, length: { in: 6..20 }


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  def visited_destinations
    self.destinations.select do |destination|
      destination.visited == true
    end
  end

end
