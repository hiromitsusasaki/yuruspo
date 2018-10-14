module LineBot
  class Service

    def call(body)
      events = LineBot::Client.instance.parse_events_from(body)
      events.each do |event|
        case event
        when Line::Bot::Event::Message
          case event.type
          when Line::Bot::Event::MessageType::Text
            response_event = ResponseEvent.new(event, EchoResponder.new)
          when Line::Bot::Event::MessageType::Image,
            Line::Bot::Event::MessageType::Video,
            Line::Bot::Event::MessageType::Audio,
            Line::Bot::Event::MessageType::File,
            Line::Bot::Event::MessageType::Location,
            Line::Bot::Event::MessageType::Sticker,
            Line::Bot::Event::MessageType::Unsupport
            response_event = ResponseEvent.new(event, ErrorResponder.new)
          end
          response_event.send
        end
      end
    end

  end
end
