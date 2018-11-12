class LineBotWorker
  include Sidekiq::Worker

  def perform(body)
    LineBot::Service.new.call(body)
  end
end
