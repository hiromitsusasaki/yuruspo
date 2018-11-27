class LineBot::ForCircle::Response::UnfollowResponse < LineBot::ForCircle::Response::BaseResponse

  private

  def is_responsible(line_bot_event)
    if line_bot_event["type"] == "unfollow"
      return true
    else
      return false
    end
  end

  def run(line_bot_event)
    unfollowing_user = User.find_or_create_by(line_user_id: line_bot_event["source"]["userId"])
    unfollowing_user.did_unfollow_bot_for_circle
  end
end
