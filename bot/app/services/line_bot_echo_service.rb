class LineBotEchoService

  def call(body)
    events = LineBotUtil.client.parse_events_from(body)
    events.each do |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          message = {
            type: 'text',
            text: event.message['text']
          }
          LineBotUtil.client.reply_message(event['replyToken'], message)
        when Line::Bot::Event::MessageType::Image,
          Line::Bot::Event::MessageType::Video,
          Line::Bot::Event::MessageType::Audio,
          Line::Bot::Event::MessageType::File,
          Line::Bot::Event::MessageType::Location,
          Line::Bot::Event::MessageType::Sticker,
          Line::Bot::Event::MessageType::Unsupport
          message = {
            type: 'text',
            text: "can't recoginize."
          }
          LineBotUtil.client.reply_message(event['replyToken'], message)
        end
      end
    end
  end


end