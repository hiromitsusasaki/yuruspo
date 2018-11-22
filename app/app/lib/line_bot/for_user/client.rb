require 'line/bot'
require 'singleton'

class LineBot::ForUser::Client < Line::Bot::Client
  include Singleton

  def initialize
    @channel_secret = ENV['YURUSPO_LINE_CHANNEL_FOR_USER_SECRET']
    @channel_token = ENV['YURUSPO_LINE_CHANNEL_FOR_USER_TOKEN']
  end

  def get_profile_params(line_user_id)
    response = LineBot::ForUser::Client.instance.get_profile(line_user_id)
    json = JSON.parse(response.body.force_encoding("UTF-8"))
    paramater = {}
    paramater[:display_name] = json["displayName"]
    paramater[:status_message] = json["statusMessage"]
    paramater[:picture_url] = json["pictureUrl"]
    return paramater
  end
end
