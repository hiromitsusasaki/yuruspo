module LineBot
  class Service

    def call(body)
      line_bot_events = LineBot::Client.instance.parse_events_from(body)
      line_bot_events.each do |line_bot_event|
        respond = LineBot::Respond.new line_bot_event
        respond.send
      end
    end
  end
end
