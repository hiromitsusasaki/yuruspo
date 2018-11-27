class LineBot::ForUser::Response::TextResponse < LineBot::ForUser::Response::BaseResponse

  attr_accessor :trigger_text

  def initialize
    super
    @trigger_texts = []#["反応するべき文字列"] とサブクラスで定義する
  end

  private

  def is_responsible(line_bot_event)
    case line_bot_event
    when Line::Bot::Event::Message
      case line_bot_event.type
      when Line::Bot::Event::MessageType::Text
        # メッセージがテキストで
        case line_bot_event.message['text']
          # テキストがtrigger_textだったら
        when *@trigger_texts
          return true
        end
      end
      return false
    end
  end

  def run(line_bot_event)
    # サブクラスで返信を送る処理をかく
    # case line_bot_event.message['text']
    # when "ほにゃらら"
    #   messages = {}
    # end
    # LineBot::ForUser::Client.instance.reply_message(line_bot_event['replyToken'], messages)
  end
end
