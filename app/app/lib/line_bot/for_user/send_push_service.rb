class LineBot::ForUser::SendPushService
  def call(user_id, messages)
    LineBot::ForUser::Client.instance.push_message(user_id, messages).body
  end
end
