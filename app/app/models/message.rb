class Message < ApplicationRecord
  belongs_to :activity

  validates :body, presence: true
end
