class LineBot::ForCircle::SendReplyService
  def call(body)
    line_bot_events = LineBot::ForCircle::Client.instance.parse_events_from(body)
    line_bot_events.each do |line_bot_event|
      responder = LineBot::ForCircle::Responder.new line_bot_event
      responder.send
    end
  end
end
