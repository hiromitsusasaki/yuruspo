class LineBot::ForUser::Response::DateResponse < LineBot::ForUser::Response::BaseResponse

  private
  # 日付が送られてきたらいつでも反応
  def is_responsible(line_bot_event)
    return false unless line_bot_event["type"] == "message"
    return false unless line_bot_event["message"]["type"] == "text"
    return false unless rep.match(line_bot_event["message"]["text"])
    return true if SearchQuery.where_line_user_id(line_bot_event["source"]["userId"]).present?
    rep = %r(([1-9]|1[0-2])/([1-9]|[12][0-9]|3[01])\(\p{Han}\))

    return false
  end

  def run(line_bot_event)
    rep = %r(([1-9]|1[0-2])/([1-9]|[12][0-9]|3[01])\((\p{Han})\))
    mm_dd_day = rep.match(line_bot_event["message"]["text"])
    wds = ["日", "月", "火", "水", "木", "金", "土"]
    date = Date.new(Time.zone.today.year, mm_dd_day[1].to_i, mm_dd_day[2].to_i)
    date = Date.new(Time.zone.today.year + 1, mm_dd_day[1].to_i, mm_dd_day[2].to_i) if wds.find_index(mm_dd_day[3]) != date.wday
    current_query = SearchQuery.where_line_user_id(line_bot_event["source"]["userId"]).order(:updated_at).last
    current_query.update(date: date, sent_activity_count: 0)
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
        text: "ごめんね。\nその日の企画はないよ(; ;)\n別の日を選んでね！"
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
