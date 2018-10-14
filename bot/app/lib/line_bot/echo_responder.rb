module LineBot

  class EchoResponder < Responder
    
    def send(response_event)
      event = response_event.event
      message = {
        type: 'text',
        text: event.message['text']
      }
      LineBot::Client.instance.reply_message(event['replyToken'], message)
    end
  end
end