class LineBot::ForCircle::Response::BaseResponse
  attr_accessor :next

  def initialize
    @next = nil
  end
end