class LineBot::ForUser::Response::TextResponse::CheckScheduleResponse < LineBot::ForUser::Response::TextResponse

  def initialize
    super
    @trigger_texts = ["予定確認"]
  end

  private

  def run(line_bot_event)
    user = User.find_by(line_user_id: line_bot_event["source"]["userId"])
    activities = Activity.joins(applications: :user).where(["user_id = ? AND date >= ?", user, Time.zone.today])
    messages = LineBot::ForUser::MessageMaker.check_schedule_messages(activities)
    LineBot::ForUser::Client.instance.reply_message(line_bot_event['replyToken'], messages)
  end
  
end
