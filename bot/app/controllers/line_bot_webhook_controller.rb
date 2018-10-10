require 'line/bot'

class LineBotWebhookController < ApplicationController

  def callback
    body = request.body.read.force_encoding("UTF-8")
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless LineBotUtil.client.validate_signature(body, signature)
      render status: 400
      return
    end
    render status: 200
    LineBotWorker.perform_async body
  end
end