class LineBot::ForUser::Response::FollowResponse < LineBot::ForUser::Response::BaseResponse
  def send(line_bot_event)
    case line_bot_event
    when Line::Bot::Event::Follow
      run(line_bot_event)
    end
    return false unless @next

    @next.send(line_bot_event)
  end

  private

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
    LineBot::ForUser::Client.instance.reply_message(line_bot_event['replyToken'], messages)
    #ここから下はユーザーを生成orアップデートしている
    saved_user = User.find_or_create_by(line_user_id: line_bot_event["source"]["userId"])
    profile_params = LineBot::ForUser::Client.instance.get_profile_params(line_bot_event["source"]["userId"])
    saved_user.assign_attributes(profile_params)
    saved_user.is_following_bot_for_user = true
    saved_user.save
  end
end
