module LineBot
  class Responder

    attr_accessor :response

    def initialize(line_bot_event)
      case line_bot_event
      when Line::Bot::Event::Message
        case line_bot_event.type
        when Line::Bot::Event::MessageType::Text
          @response = LineBot::Response::EchoResponse.new(line_bot_event)
        when Line::Bot::Event::MessageType::Image,
          Line::Bot::Event::MessageType::Video,
          Line::Bot::Event::MessageType::Audio,
          Line::Bot::Event::MessageType::File,
          Line::Bot::Event::MessageType::Location,
          Line::Bot::Event::MessageType::Sticker,
          Line::Bot::Event::MessageType::Unsupport
          @response = LineBot::Response::ErrorResponse.new(line_bot_event)
        end
      end
    end

    def send
      if @response.nil?
        raise 'Response is nil.'
      end
      @response.send
    end

  end
end