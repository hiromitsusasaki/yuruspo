class Chat < ApplicationRecord
  belongs_to :application
  belongs_to :speaker, class_name: 'User'
  validates :body, presence: true
  after_create_commit {ChatBroadcastJob.perform_later self }

  def is_from_circle_owner
    return self.circle_owner == self.speaker
  end

  def is_from_user
    return !is_from_circle_owner
  end

  def room_uri
    return "https://yuruspo.herokuapp.com/circles/#{self.application.activity.circle.id}/activities/#{self.application.activity.id}/applications/#{self.application.id}"
  end

  def users_to_notify
    # 将来的に複数になることを見越して配列で実装しているだけで今の所配列の中身は一つになる
    users = []
    users.push(self.application.user) if self.is_from_circle_owner
    users.push(self.application.activity.circle.owner) if self.is_from_user
    return users
  end

  def circle_owner
    return self.application.activity.circle.owner
  end

end
