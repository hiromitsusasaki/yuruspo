class LineBot::ForUser::ReplyWorker
  include Sidekiq::Worker

  def perform(body)
    LineBot::ForUser::Service.new.call(body)
  end
end
