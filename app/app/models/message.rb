class Message < ApplicationRecord
  belongs_to :activity

  validate :body, presence: true
end
