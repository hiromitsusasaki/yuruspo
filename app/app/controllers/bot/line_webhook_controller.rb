class Bot::LineWebhookController < ApiController
  def callback_for_user
    body = request.body.read.force_encoding("UTF-8")
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless ::LineBot::ForUser::Client.instance.validate_signature(body, signature)
      render status: 400
      return
    end
    render status: 200
    LineBot::ForUser::ReplyWorker.perform_async body
  end

  def callback_for_circle
    body = request.body.read.force_encoding("UTF-8")
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless ::LineBot::ForCircle::Client.instance.validate_signature(body, signature)
      render status: 400
      return
    end
    render status: 200
    LineBot::ForCircle::ReplyWorker.perform_async body
  end
end
