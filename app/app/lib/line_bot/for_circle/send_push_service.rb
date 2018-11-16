class LineBot::ForCircle::SendPushService
  def call(user_id, messages)
    LineBot::ForCircle::Client.instance.push_message(user_id, messages).body
  end
end
