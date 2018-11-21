class LineBot::ForUser::Response::TextResponse < LineBot::ForUser::Response::BaseResponse

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
        case line_bot_event.message['text'] #REVIEW 配列で定義したらinclude的なものになる
        when *@trigger_texts
          # runを実行
          run(line_bot_event)
        end
      end
    end
    return false unless @next

    @next.send(line_bot_event)
  end

  private

  def run(line_bot_event)
    # サブクラスで返信を送る処理をかく
  end
end
