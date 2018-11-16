class LineBot::ForCircle::ReplyWorker
  include Sidekiq::Worker

  def perform(body)
    LineBot::ForCircle::SendReplyService.new.call(body)
  end
end
