class LineBot::ForUser::Response::BaseResponse
  attr_accessor :next

  def initialize
    @next = nil
  end
end