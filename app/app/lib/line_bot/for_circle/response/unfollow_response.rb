class LineBot::ForCircle::Response::UnfollowResponse < LineBot::ForCircle::Response::BaseResponse
  def send(line_bot_event)

    case line_bot_event
    when Line::Bot::Event::Unfollow
      run(line_bot_event)
    end
    return false unless @next

    @next.send(line_bot_event)
  end

  def run(line_bot_event)
    unfollowing_user = User.find_or_create_by(line_user_id: line_bot_event["source"]["userId"])
    unfollowing_user.did_unfollow_bot_for_circle
  end
end
