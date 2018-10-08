class LineBotWebhookController < ApplicationController
  def callback
    body = request.body.read
    events = client.parse_events_from(body)

    events.each do |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          message = {
            type: 'text',
            text: event.message['text']
          }
          client.reply_message(event['replyToken'], message)
        when Line::Bot::Event::MessageType::Image,
          Line::Bot::Event::MessageType::Video,
          Line::Bot::Event::MessageType::Audio,
          Line::Bot::Event::MessageType::File,
          Line::Bot::Event::MessageType::Location,
          Line::Bot::Event::MessageType::Sticker,
          Line::Bot::Event::MessageType::Unsupport
          response = client.get_message_content(event.message['id'])
          tempfile = Tempfile.open("content")
          tempfile.write(response.body)
        end
      end
    end
    render status: 200
  end
end

