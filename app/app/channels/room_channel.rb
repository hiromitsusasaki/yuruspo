class RoomChannel < ApplicationCable::Channel
  def subscribed
    application = Application.find(params[:application_id])
    stream_for application
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    chat = Chat.new
    application = Application.find(data['chat']['application_id'])
    chat.body = data['chat']['body']
    chat.application = application
    chat.is_already_read = true
    chat.speaker = current_user
    chat.save!
  end
end
