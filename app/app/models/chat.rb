class Chat < ApplicationRecord
  belongs_to :application
  belongs_to :speaker, class_name: 'User'
  validates :body, presence: true
  after_create_commit {ChatBroadcastJob.perform_later self }
end
