require 'line/bot'

module LineBotUtil
  def self.client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV['YURUSPO_LINE_CHANNEL_SECRET']
      config.channel_token = ENV['YURUSPO_LINE_CHANNEL_TOKEN']
    end
  end
end