require 'line/bot'
require 'singleton'

class LineBot::ForUser::Client < Line::Bot::Client
  include Singleton

  def initialize
    @channel_secret = ENV['YURUSPO_LINE_CHANNEL_FOR_USER_SECRET']
    @channel_token = ENV['YURUSPO_LINE_CHANNEL_FOR_USER_TOKEN']
  end
end