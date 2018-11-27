# 実際のクラスではis_responsibleとrunだけ実装すればいい
class LineBot::ForUser::Response::BaseResponse
  attr_accessor :next

  def initialize
    @next = nil
  end

  def send(line_bot_event)
    if is_responsible(line_bot_event)
      run(line_bot_event)
    else
      return false unless @next
      @next.send(line_bot_event)
    end
  end

  private

  def is_responsible(line_bot_event)
    return false
  end

  def run(line_bot_event)
  end

end
