module LineBot
  module Response
    class EchoResponse < BaseResponse
      def send
        if @line_bot_event.nil?
          raise 'Event is nothing'
        end
        message = {
          type: 'text',
          text: @line_bot_event.message['text']
        }
        LineBot::Client.instance.reply_message(@line_bot_event['replyToken'], message)
      end
    end
  end
end
