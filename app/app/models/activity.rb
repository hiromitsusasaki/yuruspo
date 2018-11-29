class Activity < ApplicationRecord
  belongs_to :circle
  belongs_to :place_content

  has_many :applications
  has_many :chats
  has_many :activity_reviews
  has_many :messages

  delegate :content, to: :place_content
  delegate :place, to: :place_content

  def the_day_before()
    messages = remind_messages
    approved_users().each{|user|
      LineBot::ForUser::PushWorker.perform_async(user.line_user_id, messages)
    }
  end

  def approved_users
    users = []
    self.applications.where(status: :approved).each{|application|
      users.push application.user
    }
    return users
  end

  private

  def remind_messages
    messages = [
      {
        type: "text",
        text: "明日はこの活動に参加予定だよ！\n忘れないようにね！\nhttps://yurusupo.com/activities/#{self.id}"
      }
    ]
  end
end
