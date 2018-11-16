require 'line/bot'
require 'singleton'

class LineBot::ForCircle::Client < Line::Bot::Client
  include Singleton

  def initialize
    @channel_secret = ENV['YURUSPO_LINE_CHANNEL_FOR_CIRCLE_SECRET']
    @channel_token = ENV['YURUSPO_LINE_CHANNEL_FOR_CIRCLE_TOKEN']
  end
end