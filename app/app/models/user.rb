class User < ApplicationRecord
  
  has_many :user_areas
  has_many :areas, through: :user_areas
  has_many :applications
  has_many :chats, through: :applications
  has_many :user_blocks
  has_many :activity_reviews
  has_one :circle
  belongs_to :owned_circle, :class_name => 'Circle', optional: true


  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]
    display_name = auth[:info][:name]
    status_message = auth[:info][:description]
    picture_url = auth[:info][:image]

    self.find_or_create_by(provider: provider, uid: uid) do |user|
      p user
      user.display_name = display_name
      user.status_message = status_message
      user.picture_url = picture_url
      p user
    end
  end
end