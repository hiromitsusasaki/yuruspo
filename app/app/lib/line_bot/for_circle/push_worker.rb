class LineBot::ForCircle::PushWorker
  include Sidekiq::Worker

  def perform(user_id, messages)
    LineBot::ForCircle::SendPushService.new.call(user_id, messages)
  end
end
