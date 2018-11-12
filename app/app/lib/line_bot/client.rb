require 'line/bot'
require 'singleton'

module LineBot
  class Client

    include Singleton
    
    def initialize
      @client ||= Line::Bot::Client.new do |config|
        config.channel_secret = ENV['YURUSPO_LINE_CHANNEL_SECRET']
        config.channel_token = ENV['YURUSPO_LINE_CHANNEL_TOKEN']
      end
    end
    
    def validate_signature(body, signature)
      @client.validate_signature(body, signature)
    end

    def reply_message(reply_token, message)
      @client.reply_message(reply_token, message)
    end

    def parse_events_from(body)
      @client.parse_events_from(body)
    end

  end
end