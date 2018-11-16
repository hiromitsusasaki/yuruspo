class LineBot::ForUser::SendReplyService
  def call(body)
    line_bot_events = LineBot::ForUser::Client.instance.parse_events_from(body)
    line_bot_events.each do |line_bot_event|
      responder = LineBot::ForUser::Responder.new line_bot_event
      responder.send
    end
  end
end
