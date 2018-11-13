class Activity < ApplicationRecord
  belongs_to :circle
  belongs_to :place_content
  
  has_many :applications
  has_many :chats
  has_many :activity_reviews
  has_many :messages
end
