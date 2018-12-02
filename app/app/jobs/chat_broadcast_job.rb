class ChatBroadcastJob < ApplicationJob
  queue_as :default

  def perform(chat)
    RoomChannel.broadcast_to chat.application, chat: render_chat(chat)
  end

  private
  def render_chat(chat)
    ApplicationController.renderer.render(partial: 'webapp/applications/chat_body', locals: {chat: chat})
  end
end