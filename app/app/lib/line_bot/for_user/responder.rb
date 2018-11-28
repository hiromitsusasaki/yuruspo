class LineBot::ForUser::Responder
  attr_accessor :line_bot_event

  def initialize(_line_bot_event)
    @line_bot_event = _line_bot_event
  end

  def send
    responses = []
    # responses.push(LineBot::ForUser::Response::EchoResponse.new)
    responses.push(LineBot::ForUser::Response::ImageResponse.new)
    responses.push(LineBot::ForUser::Response::TextResponse::HelpResponse.new)
    responses.push(LineBot::ForUser::Response::ContentsNameResponse.new)
    responses.push(LineBot::ForUser::Response::CitiesNameResponse.new)
    responses.push(LineBot::ForUser::Response::DateResponse.new)
    responses.push(LineBot::ForUser::Response::TextResponse::WantSportsResponse.new)
    responses.push(LineBot::ForUser::Response::OtherActivityResponse.new)
    responses.push(LineBot::ForUser::Response::FollowResponse.new)
    responses.push(LineBot::ForUser::Response::UnfollowResponse.new)
    responses.push(LineBot::ForUser::Response::InquiryReponse.new)
    responses.push(LineBot::ForUser::Response::ErrorResponse.new)
    set_chain_of responses
    responses[0].send(@line_bot_event)
  end

  # 一つ後ろのindexの中身をnextに指定
  def set_chain_of responses
    responses.each_with_index{|response, index|
      response.next = responses[index + 1] unless index == responses.count
    }
  end
end
