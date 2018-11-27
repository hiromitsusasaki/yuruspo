class LineBot::ForCircle::Response::ErrorResponse < LineBot::ForUser::Response::BaseResponse

  private

  def is_responsible(line_bot_event)
    return true
  end

  def run(line_bot_event)
    message = {
      type: 'text',
      text: 'わかりません。'
    }
    LineBot::ForCircle::Client.instance.reply_message(line_bot_event['replyToken'], message)
  end
end
