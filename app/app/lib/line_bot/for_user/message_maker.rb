class LineBot::ForUser::MessageMaker
  
  def self.suggest_dates_carousel_message(query)
    carousel_message = {
      type: "template",
      altText: "this is a carousel template",
      template: {
        type: "carousel",
        actions: [],
        columns: []
      }
    }
    wds = ["日", "月", "火", "水", "木", "金", "土"]
    # カラムを7つつくる
    wds.each_with_index{|wd, wdi|
      column = {
        title: "#{wd}曜日",
        text: "❌のところは企画がないよ。",
        actions: []
      }
      # カラムの中にアクションを3つ作る(LINEMessagingAPIの仕様上三つが最大)
      for wsi in 0..2 do
        action = {
          type: "message",
          label: "ー",
          text: "ー"
        }
        date = Time.zone.today - Time.zone.today.wday + wdi + wsi*7# 日曜日に直して、曜日ぶん足し算して週単位で進める
        marubatu = Activity.where_query(query).where(date: date).present? ? "⭕️":"❌"
        action[:label] = date.strftime("%-m/%-d") + " (#{wd})" + marubatu if date >= Time.zone.today
        action[:text] = date.strftime("%-m/%-d") + "(#{wd})" if date >= Time.zone.today
        column[:actions].push(action)
      end
      carousel_message[:template][:columns].push(column)
    }
    return carousel_message
  end

  def self.suggest_activity_message(activity)
    wds = ["日", "月", "火", "水", "木", "金", "土"]
    message = {
      type: "template",
      altText: "this is a buttons template",
      template: {
        type: "buttons",
        actions: [
          {
            type: "uri",
            label: "詳しく見る",
            uri: "https://www.flopdesign.com/freefont/flopdesignfont.html"#TODO: リンク
          },
          {
            type: "message",
            label: "他の活動を探す",
            text: "他の活動"
          }
        ],
        thumbnailImageUrl: "https://illustimage.com/photo/117.png",#TODO:リンク
        title: "#{activity.date.strftime("%-m/%-d(#{wds[activity.date.wday]})")} #{activity.place_content.content.name}",
        text: "場所: #{activity.place_content.place.name}"
      }
    }
    return message
  end
end
