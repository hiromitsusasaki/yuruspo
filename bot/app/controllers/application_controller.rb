require 'line/bot'

class ApplicationController < ActionController::API

  before_action :validate_signature
  
  def validate_signature
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      render status: 400
    end
  end
  
  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV['YURUSPO_LINE_CHANNEL_SECRET']
      config.channel_token = ENV['YURUSPO_LINE_CHANNEL_TOKEN']
      # if you run this only local, you can write directly channel secret and token
      # config.channel_secret = "your channel secret"
      # config.channel_token = "your channel token"
    end
  end

end
