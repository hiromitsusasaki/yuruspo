class LineBot::ForUser::Response::TextResponse::SearchActivityResponse < LineBot::ForUser::Response::TextResponse

  def initialize
    super
    @trigger_texts = ["スポーツしたい！"]
  end

  private

  def run(line_bot_event)
    # サブクラスで返信を送る処理をかく
    if SearchQuery.find_by_line_user_id(line_bot_event["source"]["userId"]).empty?
      # 一番最初の処理
      messages = first_reply_messages
      LineBot::ForUser::Client.instance.reply_message(line_bot_event['replyToken'], messages)
      SearchQuery.create_with_line_user_id(line_bot_event["source"]["userId"]).save
    elsif 
      # ２回目以降の処理

    end
  end

  def first_reply_messages
    messages = [
      {
        type: "text",
        text: "こんにちはー！\n話しかけてくれてありがとー！\nやりたい競技はどれかな？"
      },
      {
        type: "imagemap",
        baseUrl: Constants::S3::ForUser::SPORTS_KIND_IMAGE,
        altText: "",
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
  end

end
