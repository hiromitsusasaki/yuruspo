module LineBot
  module Response
    class ErrorResponse < BaseResponse
      def send(line_bot_event)
        case line_bot_event
        when Line::Bot::Event::Message
          case line_bot_event.type
          when Line::Bot::Event::MessageType::Image,
            Line::Bot::Event::MessageType::Video,
            Line::Bot::Event::MessageType::Audio,
            Line::Bot::Event::MessageType::File,
            Line::Bot::Event::MessageType::Location,
            Line::Bot::Event::MessageType::Sticker,
            Line::Bot::Event::MessageType::Unsupport
            run(line_bot_event)
            return true
          end
        end
        return false unless @next
        @next.send(line_bot_event)
      end
      
      private
      def run(line_bot_event)
        message = {
          type: 'text',
          text: 'わかりません。'
          }
          LineBot::Client.instance.reply_message(line_bot_event['replyToken'], message)
      end
    end
  end
end