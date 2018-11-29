class Activity < ApplicationRecord
  belongs_to :circle
  belongs_to :place_content
  
  has_many :applications
  has_many :activity_reviews
  has_many :messages

  delegate :content, to: :place_content
  delegate :place, to: :place_content
end
