class LineBot::SendChatNotificationWorker
  include Sidekiq::Worker

  def perform(chat_id)
    chat = Chat.find(chat_id)
    chat.users_to_notify.each{|user|
      LineBot::ForUser::PushWorker.perform_async(user.line_user_id, chat_message(chat)) if chat.circle_owner != user
      LineBot::ForCircle::PushWorker.perform_async(user.line_user_id, chat_message(chat)) if chat.circle_owner == user
    }
  end

  private

  def chat_message(chat)
    from = chat.speaker.display_name if chat.is_from_user
    from = chat.application.activity.circle.name if chat.is_from_circle_owner
    message = {
      "type": "text",
      "text": "#{from}さんからメッセージがきました。\n返信はリンクからできます。\n\n-----------------\n#{chat.body}\n-----------------\n#{chat.room_uri}"
    }
    return message
  end
end
