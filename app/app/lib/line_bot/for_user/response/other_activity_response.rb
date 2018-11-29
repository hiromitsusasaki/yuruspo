class LineBot::ForUser::Response::OtherActivityResponse < LineBot::ForUser::Response::BaseResponse

  private

  # 全てコンプリート済みで「他の活動」と送られてきたらtrue
  def is_responsible(line_bot_event)
    return false unless line_bot_event["type"] == "message"
    return false unless line_bot_event["message"]["type"] == "text"
    return false unless line_bot_event["message"]["text"] == "他の活動"
    return true if SearchQuery.not_completed_query(line_bot_event["source"]["userId"]).blank? # つまり全てがコンプリートしていたら

    return false
  end

  def run(line_bot_event)
    current_query = SearchQuery.order(:updated_at).last
    return false unless current_query.present?
    current_query.update(sent_activity_count: current_query.sent_activity_count + 1)
    messages = query_result_messages(current_query)
    LineBot::ForUser::Client.instance.reply_message(line_bot_event['replyToken'], messages)
  end


    def query_result_messages(current_query)
      activity  = Activity.an_activity_with_query(current_query)
      if activity.nil?
        current_query.update(date: nil, sent_activity_count: nil)
        return nothing_messages(current_query)
      else
        return activity_messages(activity)
      end
    end


    def nothing_messages(current_query)
      messages = [
        {
          type: "text",
          text: "ごめんね。\nその日の企画はもうないよ(; ;)\n別の日を選んでね！"
        }
      ]
      messages.push(LineBot::ForUser::MessageMaker.suggest_dates_carousel_message(current_query))
      return messages
    end

    def activity_messages(activity)
      messages = [
        {
          type: "text",
          text: "おっけー！\nこんな企画はどうでしょう！"
        }
      ]
      messages.push(LineBot::ForUser::MessageMaker.suggest_activity_message(activity))
    end


end
