class User < ApplicationRecord

  has_many :applications
  has_many :chats, through: :applications
  has_many :user_blocks
  has_many :activity_reviews
  has_many :chats
  has_one :circle
  has_many :blocked_circles, source: 'circle', through: :user_blocks 
  validates :line_user_id, presence: true


  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    line_user_id = auth[:uid]
    display_name = auth[:info][:name]
    status_message = auth[:info][:description]
    picture_url = auth[:info][:image]

    self.find_or_create_by(line_user_id: line_user_id) do |user|
      user.provider = provider
      user.display_name = display_name
      user.status_message = status_message
      user.picture_url = picture_url
    end
  end

  def did_unfollow_bot_for_user
    self.update(is_following_bot_for_user: false)
  end

  def did_unfollow_bot_for_circle
    self.update(is_following_bot_for_circle: false)
  end

  def has_circle?
    !owned_circle.nil?
  end

  def owned_circle
    Circle.find_by(owner: self)
  end

  def is_blocked?(circle)
    if blocked_circles.empty?
      false
    else
      blocked_circles.find(circle.id).nil?
    end
  end
end
