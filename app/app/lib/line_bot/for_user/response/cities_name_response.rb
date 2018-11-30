class LineBot::ForUser::Response::CitiesNameResponse < LineBot::ForUser::Response::BaseResponse

  private
  # not_completed_queryが存在して、cityの名前だった時true
  def is_responsible(line_bot_event)

    return false unless line_bot_event["type"] == "message"
    return false unless line_bot_event["message"]["type"] == "text"
    return false unless City.where_like(line_bot_event["message"]["text"]).present?
    return true if SearchQuery.not_completed_query(line_bot_event["source"]["userId"]).present?

    return false
  end

  def run(line_bot_event)
    current_query = SearchQuery.not_completed_query(line_bot_event["source"]["userId"])
    messages = []
    cities = City.where_like(line_bot_event["message"]["text"])
    if cities.count == 1
      current_query.city = cities.first
      current_query.save
      today = Time.zone.today
      two_weeks_ago_sunday = today - today.wday - 1  + 7*3
      if Activity.where_query(current_query).where(date: today..two_weeks_ago_sunday).present?#TODO: 日付の範囲を今日から再来週の日曜までに指定したいところではある。
        # その街の活動が存在したら
        messages = when_messages(current_query)
      else
        # その街の活動が存在しなかったら
        messages = no_activity_messages(current_query)
      end
    else
      current_query.save
      messages = which_city_messages(cities, line_bot_event["message"]["text"])
    end
    LineBot::ForUser::Client.instance.reply_message(line_bot_event['replyToken'], messages)
  end

  def when_messages(current_query)
    messages = [
      {
        type: "text",
        text: "おっけー\n#{current_query.city.with_prefecture_name}だね！\n日にちはいつがいい？"
      }
    ]
    messages.push(LineBot::ForUser::MessageMaker.suggest_dates_carousel_message(current_query))
    return messages
  end

  def no_activity_messages(current_query)
    messages = [
      {
        type: "text",
        text: "ごめんね。\n#{current_query.city.with_prefecture_name}の活動はまだないよ(; ;)\n別の市区町村を指定してみてね！"
      }
    ]
    return messages
  end

  def which_city_messages(cities, city_name)
    Rails.logger.warn("四つ以上の名前発生: #{city_name}") if cities.count > 4
    messages = [
      {
        type: "template",
        altText: "this is a buttons template",
        template: {
          type: "buttons",
          actions: [],
          title: "複数あったよ",
          text: "どれが正しいですか？"
        }
      }
    ]
    cities.each_with_index{|city, i|
      break unless i < 4
      messages.last[:template][:actions].push(
        {
          type: "message",
          label: city.with_prefecture_name,
          text: city.name
        }
      )
    }
    return messages
  end
end
