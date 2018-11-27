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
        "text": "こんにちは！\nゆるすぽを使うとサクッとバスケやフットサルが楽しめるよ！\nスポーツをしたい！って思ったら僕に「バスケしたい」とか言ってね！\n(スポーツ情報)を提供するよ！\n\n\nゆるすぽについての詳しい情報はこのサイトに書いてあるよ😊\n\nhttps://atnd.org/events/76336" #TODO: リンク
      },
      {
        "type": "text",
        "text": "詳しい使い方は下のメニューから見れるよ！\nメニュー→使い方から説明を見たい使い方を選んでね"
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
