class LineBot::ForUser::Response::TextResponse::WantSportsResponse < LineBot::ForUser::Response::TextResponse

  def initialize
    super
    @trigger_texts = ["スポーツしたい！"]
  end

  private

  def run(line_bot_event)
    SearchQuery.create_with_line_user_id(line_bot_event["source"]["userId"])
    messages = reply_messages
    LineBot::ForUser::Client.instance.reply_message(line_bot_event['replyToken'], messages)
    # コメントアウトは将来的に処理を分けるかもって感じのもの。データが集まって同じ設定で検索する人が多いことがわかったら実装でいい気がした。
    # if SearchQuery.where_line_user_id(line_bot_event["source"]["userId"]).empty?
    #   # もしそのユーザーに検索履歴がなかったら
    #   when_no_history(line_bot_event)
    # elsif SearchQuery.not_completed_query(line_bot_event["source"]["userId"]).present?
    #   # もしそのユーザーの検索履歴に完了していない状態のものがあったら
    #   when_not_completed_query_present(line_bot_event)
    # else
    #   # もしそのユーザーの検索履歴があって、全てちゃんと完了していたら
    #   when_has_completed_history(line_bot_event)
    # end
  end








  # コメントアウトは将来的に分けるかもって感じのもの。データが集まって同じ設定で検索する人が多いことがわかったら実装でいい気がした。
  # # SearchQueryを生成して、スポーツ選択イメージマップを返信する
  # def when_no_history(line_bot_event)
  #   SearchQuery.create_with_line_user_id(line_bot_event["sorce"]["userId"])
  #   messages = no_history_reply_messages
  #   LineBot::ForUser::Client.instance.reply_message(line_bot_event['replyToken'], messages)
  # end
  #
  # # これが終わってないけどいい？って聞く
  # def when_not_completed_query_present(line_bot_event)
  #
  # end
  #
  # # 前回の履歴残ってるけどこれ使う？って聞く
  # def when_has_completed_history(line_bot_event)
  #
  # end



  def reply_messages
    messages = [
      {
        type: "text",
        text: "こんにちはー！\n話しかけてくれてありがとー！\nやりたい競技はどれかな？"
      },
      {
        type: "imagemap",
        baseUrl: Constants::S3::ForUser::SPORTS_KIND_IMAGE_URL,
        altText: "画像を読み込んでね",
        baseSize: {
          width: 375,
          height: 254
        },
        actions: [
          {
            type: "message",
            text: "バスケ",
            area: {
              x: 0,
              y: 0,
              width: 125,
              height: 127
            }
          },
          {
            type: "message",
            text: "フットサル",
            area: {
              x: 125,
              y: 0,
              width: 125,
              height: 127
            }
          },
          {
            type: "message",
            text: "バレー",
            area: {
              x: 250,
              y: 0,
              width: 125,
              height: 127
            }
          },
          {
            type: "message",
            text: "野球",
            area: {
              x: 0,
              y: 127,
              width: 125,
              height: 127
            }
          },
          {
            type: "message",
            text: "テニス",
            area: {
              x: 125,
              y: 127,
              width: 125,
              height: 127
            }
          },
          {
            type: "message",
            text: "バドミントン",
            area: {
              x: 250,
              y: 127,
              width: 125,
              height: 127
            }
          }
        ]
      }
    ]
    return messages
  end
end
