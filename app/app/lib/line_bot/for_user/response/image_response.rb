class LineBot::ForUser::Response::ImageResponse < LineBot::ForUser::Response::BaseResponse

  private

  def is_responsible(line_bot_event)
    case line_bot_event
    when Line::Bot::Event::Message
      case line_bot_event.type
      when Line::Bot::Event::MessageType::Image
        return true
      end
    end
    return false
  end

  def run(line_bot_event)
    message = {
      type: 'text',
      text: '素敵な写真ですね。'
    }
    LineBot::ForUser::Client.instance.reply_message(line_bot_event['replyToken'], message)
  end
end
