class LineBot::ForCircle::Response::TextResponse::InquiryResponse < LineBot::ForCircle::Response::TextResponse

  attr_accessor :trigger_text

  def initialize
    super
    @trigger_texts = ["お問い合わせ"]
  end

  private

  def run(line_bot_event)
    # サブクラスで返信を送る処理をかく
    case line_bot_event.message['text']
    when @trigger_texts[0]
      messages = to_inquiry_messages
      sending_user = User.find_by(line_user_id: line_bot_event['source']['userId'])
      sending_user.update(flag_about_to_ask_circle_bot: true)
      LineBot::ForCircle::CancellFlagWorker.perform_in 30.minutes, "flag_about_to_ask_circle_bot", sending_user.line_user_id
    end
    LineBot::ForCircle::Client.instance.reply_message(line_bot_event['replyToken'], messages)
  end

  def to_inquiry_messages
    #TODO: どんな仕様にしましょうかね。笑
    messages = [
      {
        type: "text",
        text: "お問い合わせありがとうございます。\nこのままここにLINEでメッセージを送るとお問い合わせが完了します。\nメッセージは一つ分しか届かないのでご注意ください。"
      }
    ]
    return messages
  end
end
