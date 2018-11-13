class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :user_areas
  has_many :areas, through: :user_areas
  has_many :applications
  has_many :chats, through: :applications
  has_many :user_blocks
  has_many :activity_reviews
  has_one :circle


end
