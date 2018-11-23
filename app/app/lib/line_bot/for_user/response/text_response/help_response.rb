class LineBot::ForUser::Response::TextResponse::HelpResponse < LineBot::ForUser::Response::TextResponse

  attr_accessor :trigger_text

  def initialize
    super
    @trigger_texts = ["ヘルプ", "スポーツの仕方は？", "よくある質問", "お問い合わせ"]
  end

  private

  def run(line_bot_event)
    # サブクラスで返信を送る処理をかく
    case line_bot_event.message['text']
    when @trigger_texts[0]
      messages = to_help_messages
    when @trigger_texts[1]
      messages = to_howto_messages
    when @trigger_texts[2]
      messages = to_frecent_questions_messages
    when @trigger_texts[3]
      messages = to_inquiry_messages
      sending_user = User.find_by(line_user_id: line_bot_event['source']['userId'])
      sending_user.update(flag_is_about_to_asking: true)
      LineBot::ForUser::CancellFlagWorker.perform_in 30.minutes, "flag_is_about_to_asking", sending_user.line_user_id
    end
    LineBot::ForUser::Client.instance.reply_message(line_bot_event['replyToken'], messages)
  end

  def to_help_messages
    messages = [
      {
        type: 'text',
        text: "こんにちは！\n下のヘルプメニューから好きなヘルプを選んでね！"
      },
      {
        type: 'imagemap',#TODO: 直す
        baseUrl: Constants::S3::ForUser::HELP_MENUS_URL,
        altText: "スポーツの仕方が知りたいときは上半分を、よくある質問が知りたいときは左下を、お問い合わせがしたいときは右下を押してね",
        baseSize: {
          width: 375,
          height: 254
        },
        actions: [
          {
            type: "message",
            text: @trigger_texts[1],
            area: {
              x: 0,
              y: 0,
              width: 375,
              height: 127
            }
          },
          {
            type: "message",
            text: @trigger_texts[2],
            area: {
              x: 0,
              y: 127,
              width: 187,
              height: 127
            }
          },
          {
            type: "message",
            text: @trigger_texts[3],
            area: {
              x: 187,
              y: 127,
              width: 188,
              height: 127
            }
          }
        ]
      }
    ]
    return messages
  end

  def to_howto_messages
    messages = [
      {
        type: 'text',
        text: "スポーツの仕方だね！\n企画に参加するまでの流れはこんな感じだよ！\n\n1. メニューから赤色の「スポーツしたい！」を押す！\n\n2. 僕がする「競技, 地域, 時間」の三つの質問に答える！\n\n3. 企画が送られてくるからそれをみる！ちなみにそのページから企画者とチャットもできるよ！\n\n4. 参加してみたい企画だったら参加希望ボタンをおす！\n\n5. 参加希望が承認されたら企画に遊びに行ってスポーツができるよ！\n\nもっと詳しい手順がみたいときはここから見れるよ！\n気になったらみてね！\nリンク" #TODO: リンク
      }
    ]
    return messages
  end

  def to_frecent_questions_messages
    messages = [
      {
        type: "text",
        text: "よくある質問だね！\nよくある質問はこのページにまとめられてるよ！\n見てみてね！\nリンク"#TODO リンク
      },
      {
        type: "text",
        text: "もしよくある質問に知りたい情報がなかったらお問い合わせから気軽に質問してね！\n僕を作った人が対応するよ！"
      }
    ]
    return messages
  end

  def to_inquiry_messages
    #TODO: どんな仕様にしましょうかね。笑
    messages = [
      {
        type: "text",
        text: "お問い合わせありがとう！\n次に君が送る文章が僕を作った人にそのまま届くよ！\nメッセージは一つ分しか届かないから送りたい内容は一回で送ってね！"
      }
    ]
    return messages
  end
end
