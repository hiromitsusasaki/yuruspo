class Bot::LineWebhookController < ApiController
  def callback
    body = request.body.read.force_encoding("UTF-8")
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless ::LineBot::ForUser::Client.instance.validate_signature(body, signature)
      render status: 400
      return
    end
    render status: 200
    LineBot::ForUser::ReplyWorker.perform_async body
  end
end
