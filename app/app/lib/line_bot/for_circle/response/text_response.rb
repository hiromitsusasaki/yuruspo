class LineBot::ForCircle::Response::TextResponse < LineBot::ForCircle::Response::BaseResponse

  attr_accessor :trigger_text

  def initialize
    super
    @trigger_texts = []#["反応するべき文字列"] とサブクラスで定義する
  end

  def send(line_bot_event)
    # メッセージイベントで
    case line_bot_event
    when Line::Bot::Event::Message
      # メッセージがテキストで
      case line_bot_event.type
      when Line::Bot::Event::MessageType::Text
        # テキストがtrigger_textだったら
        case line_bot_event.message['text']
        when *@trigger_texts
          # runを実行
          run(line_bot_event)
          return true
        end
      end
    end
    return false unless @next

    @next.send(line_bot_event)
  end

  private

  def run(line_bot_event)
    # サブクラスで返信を送る処理をかく
    # case line_bot_event.message['text']
    # when "ほにゃらら"
    #   messages = {}
    # end
    # LineBot::ForCircle::Client.instance.reply_message(line_bot_event['replyToken'], messages)
  end
end
