module LineBot
  class Service

    def call(body)
      line_bot_events = LineBot::Client.instance.parse_events_from(body)
      line_bot_events.each do |line_bot_event|
        responder = LineBot::Responder.new line_bot_event
        responder.send
      end
    end
  end
end
