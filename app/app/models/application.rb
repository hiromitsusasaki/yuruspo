class Application < ApplicationRecord
  belongs_to :user
  belongs_to :activity
  has_many :chats, dependent: :destroy 

  validates :user, uniqueness: {scope: [:activity]}

  enum status: {only_chat: 0, requested: 1, approved: 2}
end
