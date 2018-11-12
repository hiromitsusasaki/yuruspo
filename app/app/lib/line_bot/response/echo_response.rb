module LineBot
  module Response
    class EchoResponse < BaseResponse
      def send(line_bot_event)
        case line_bot_event
        when Line::Bot::Event::Message
          case line_bot_event.type
          when Line::Bot::Event::MessageType::Text
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
          text: line_bot_event.message['text']
        }
        LineBot::Client.instance.reply_message(line_bot_event['replyToken'], message)
      end
    end
  end
end
