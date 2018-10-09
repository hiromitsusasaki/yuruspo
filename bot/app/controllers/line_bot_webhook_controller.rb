class LineBotWebhookController < ApplicationController
  def callback
    body = request.body.read.force_encoding("UTF-8")
    puts body.class
    LineBotEchoWorker.perform_async body
    render status: 200
  end
end

