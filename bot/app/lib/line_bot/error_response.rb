module LineBot
  class ErrorResponse < BaseResponse
    
    def send
      if @line_bot_event.nil?
        raise 'Linebot Event is nothing'
      end
      message = {
        type: 'text',
        text: 'わかりません。'
        }
        LineBot::Client.instance.reply_message(@line_bot_event['replyToken'], message)
    end
  end
end