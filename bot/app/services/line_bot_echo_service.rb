class LineBotEchoService

  def call(body)
    puts 'start service.'
    events = LineBotUtil.client.parse_events_from(body)
    events.each do |event|
      puts 'start processing to event.'
      case event
      when Line::Bot::Event::Message
        puts 'event is message.'
        case event.type
        when Line::Bot::Event::MessageType::Text
          puts 'message is text.'
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
          puts 'message is not text.'
          message = {
            type: 'text',
            text: "can't recoginize."
          }
          LineBotUtil.client.reply_message(event['replyToken'], message)
        end
      end
      puts 'end processing to event.'
    end
    puts 'end service.'
  end
end