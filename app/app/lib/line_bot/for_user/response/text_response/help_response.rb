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
    end
    LineBot::ForUser::Client.instance.reply_message(line_bot_event['replyToken'], messages)
  end

  def to_help_messages
    messages = [
      {
        type: 'text',
        text: 'こんにちは！\n下のヘルプメニューから好きなヘルプを選んでね！'
      },
      {
        type: 'imagemap',#TODO: 直す
        baseUrl: "https://s3-ap-northeast-1.amazonaws.com/yurusupo-bot-public-images/for_user/help_menus",
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
        type: text,
        text: "スポーツの仕方だね！
        企画に参加するまでの流れはこんな感じだよ！

        1. メニューから赤色の「スポーツしたい！」を押す！

        2. 僕がする「競技, 地域, 時間」の三つの質問に答える！

        3. 企画が送られてくるからそれをみる！ちなみにそのページから企画者とチャットもできるよ！

        4. 参加してみたい企画だったら参加希望ボタンをおす！

        5. 参加希望が承認されたら企画に遊びに行ってスポーツができるよ！

        もっと詳しい手順がみたいときはここから見れるよ！
        気になったらみてね！"
      }
    ]
  end

  def to_frecent_questions_messages
  end

  def to_inquiry_messages
  end
end
