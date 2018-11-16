class LineBot::ForUser::ReplyWorker
  include Sidekiq::Worker

  def perform(body)
    LineBot::ForUser::SendReplyService.new.call(body)
  end
end
