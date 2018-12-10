class LineBot::ForCircle::Response::FollowResponse < LineBot::ForCircle::Response::BaseResponse

  private

  def is_responsible(line_bot_event)
    if line_bot_event["type"] == "follow"
      return true
    else
      return false
    end
  end

  def run(line_bot_event)
    messages = [
      {
        "type": "text",
        "text": "友達登録ありがとうございます。\nゆるすぽは誰でも参加OKなスポーツ企画に人を集めることができるサービスです。企画の作成はメニューの右下のプラスボタンからできます。" #TODO: リンク
      }
    ]
    LineBot::ForCircle::Client.instance.reply_message(line_bot_event['replyToken'], messages)
    #ここから下はユーザーを生成orアップデートしている
    saved_user = User.find_or_create_by(line_user_id: line_bot_event["source"]["userId"])
    profile_params = LineBot::ForCircle::Client.instance.get_profile_params(line_bot_event["source"]["userId"])
    saved_user.assign_attributes(profile_params)
    saved_user.is_following_bot_for_circle = true
    saved_user.save
  end
end
