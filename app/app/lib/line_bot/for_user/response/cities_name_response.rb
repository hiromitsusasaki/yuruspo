class LineBot::ForUser::Response::CitiesNameResponse < LineBot::ForUser::Response::BaseResponse

  private
  # not_completed_queryが存在して、cityの名前だった時true
  def is_responsible(line_bot_event)

  end

  def run(line_bot_event)
    message = {
      type: 'text',
      text: line_bot_event.message['text']
    }
    LineBot::ForUser::Client.instance.reply_message(line_bot_event['replyToken'], message)
  end
end
