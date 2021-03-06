class LineBot::ForCircle::Response::EchoResponse < LineBot::ForCircle::Response::BaseResponse
  
  private
  def is_responsible(line_bot_event)
    case line_bot_event
    when Line::Bot::Event::Message
      case line_bot_event.type
      when Line::Bot::Event::MessageType::Text
        return true
      end
    end
    return false
  end


  def run(line_bot_event)
    message = {
      type: 'text',
      text: line_bot_event.message['text']
    }
    LineBot::ForCircle::Client.instance.reply_message(line_bot_event['replyToken'], message)
  end
end
