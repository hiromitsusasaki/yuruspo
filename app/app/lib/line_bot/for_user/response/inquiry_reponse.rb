class LineBot::ForUser::Response::InquiryReponse < LineBot::ForUser::Response::BaseResponse

  private

  def is_responsible(line_bot_event)
    # お問い合わせモードでメッセージが送られてきたら対応
    if User.find_by(line_user_id: line_bot_event["source"]["userId"]).flag_about_to_ask_user_bot && line_bot_event["type"] == "message"
      return true
    else
      return false
    end
  end

  def run(line_bot_event)
    if line_bot_event["message"]["type"] == "text"
      inquiryUser = User.find_by(line_user_id: line_bot_event["source"]["userId"])
      inquiryUser.update(flag_about_to_ask_user_bot: false)
      Inquiry.new(user_id: inquiryUser.id, body: line_bot_event["message"]["text"], is_responded: false).save
      messages = success_messages
    else
      messages = failure_messages
    end
    LineBot::ForUser::Client.instance.reply_message(line_bot_event['replyToken'], messages)
  end

  def success_messages
    messages = [
      {
        type: 'text',
        text: "お問い合わせありがとう！\n無事におくれたよ！"
      }
    ]
    return messages
  end

  def failure_messages
    messages = [
      {
        type: 'text',
        text: "文章以外は送れないよ！\nもう一度文章を送ってね！"
      }
    ]
  end
end
