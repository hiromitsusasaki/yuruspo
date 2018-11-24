class LineBot::ForCircle::Responder
  attr_accessor :line_bot_event

  def initialize(_line_bot_event)
    @line_bot_event = _line_bot_event
  end

  def send
    responses = []
    # responses.push(LineBot::ForCircle::Response::EchoResponse.new)
    responses.push(LineBot::ForCircle::Response::ImageResponse.new)
    responses.push(LineBot::ForCircle::Response::FollowResponse.new)
    responses.push(LineBot::ForCircle::Response::UnfollowResponse.new)
    responses.push(LineBot::ForCircle::Response::ErrorResponse.new)
    set_chain_of responses
    responses[0].send(@line_bot_event)
  end

  private
  # 一つ後ろのindexの中身をnextに指定
  def set_chain_of responses
    responses.each_with_index{|response, index|
      response.next = responses[index + 1] unless index == responses.count
    }
  end
end
