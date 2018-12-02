class Chat < ApplicationRecord
  belongs_to :application
  after_create_commit {ChatBroadcastJob.perform_later self }

  enum speaker: {user: 0, circle: 1}
end
