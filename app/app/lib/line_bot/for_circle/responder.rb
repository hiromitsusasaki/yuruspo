class LineBot::ForCircle::Responder
  attr_accessor :line_bot_event

  def initialize(_line_bot_event)
    @line_bot_event = _line_bot_event
  end

  def send
    echo_response = LineBot::ForCircle::Response::EchoResponse.new
    image_response = LineBot::ForCircle::Response::ImageResponse.new
    echo_response.next = image_response
    error_response = LineBot::ForCircle::Response::ErrorResponse.new
    image_response.next = error_response
    echo_response.send(@line_bot_event)
  end
end
