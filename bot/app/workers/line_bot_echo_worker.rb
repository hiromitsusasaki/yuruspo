require 'line/bot'

class LineBotEchoWorker
  include Sidekiq::Worker

  def perform(body)
    LineBotEchoService.new.call(body)
  end
end
