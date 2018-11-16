class LineBot::ForUser::PushWorker
  include Sidekiq::Worker

  def perform(user_id, messages)
    LineBot::ForUser::SendPushService.new.call(user_id, messages)
  end
end
