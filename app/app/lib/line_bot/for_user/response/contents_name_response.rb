class LineBot::ForUser::Response::ContentsNameResponse < LineBot::ForUser::Response::BaseResponse

  private

  # バスケなどと送られてきたとき
  def is_responsible(line_bot_event)

    return false unless line_bot_event["type"] == "message"
    return false unless line_bot_event["message"]["type"] == "text"
    return true if Content.where(name: line_bot_event["message"]["text"]).present?
    
    return false
  end

  def run(line_bot_event)
    # クエリに代入
    current_query = SearchQuery.not_completed_query(line_bot_event["source"]["userId"])
    current_query ||= SearchQuery.create_with_line_user_id(line_bot_event["source"]["userId"])
    current_query.content = Content.where(name: line_bot_event["message"]["text"]).first
    current_query.save
    # メッセージを返す
    messages = proper_messages(line_bot_event)
    LineBot::ForUser::Client.instance.reply_message(line_bot_event['replyToken'], messages)
  end

  # そのうち場合分けが必要になると思うので。
  def proper_messages(line_bot_event)
    content_name = line_bot_event["message"]["text"]
    messages = [
      {
        type: "text",
        text: "おっけー！\n#{content_name}だね！\n#{content_name}はどこらへんでしたい？\n市区町村で答えてね！\n(左下からキーボードを出して文で送ってください！)"
      }
    ]
    return messages
  end
end
