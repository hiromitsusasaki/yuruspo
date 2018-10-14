module LineBot
  class ErrorResponder < Responder

    def send(response_event)
      event = response_event.event
      message = {
        type: 'text',
        text: 'わかりません。'
        }
        LineBot::Client.instance.reply_message(event['replyToken'], message)
    end
  end
end