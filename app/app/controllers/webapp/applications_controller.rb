class Webapp::ApplicationsController < ApplicationController

  before_action :authenticate

  def create
    application = Application.create(activity_id: params[:activity_id], user_id: current_user.id)
    if params[:is_join_request]
      application.status = :requested
      application.save
      chat = Chat.create(application_id: application.id, speaker: :user, body: "参加リクエストを送りました")
    end
    redirect_to :action => 'show', :circle_id => application.activity.circle.id, :activity_id => application.activity.id, :application_id => application.id
  end

  def show
    p params
    @application = Application.find(params[:application_id])
    # @chats = Chat.where(application_id: params[:application_id])
    @chats = dummy_chats(@application)
    if @application.activity.circle.owner == current_user
      @chats.each do |chat|
        if !chat.is_already_read
          chat.is_already_read = true
          chat.save
        end
      end
    end
  end

  private 
  
  def dummy_chats(application)
    chats = []
    for num in 0..20 do
      chat = Chat.new(application: application)
      chat.body = "ああああああああああああああああああああああああ"
      if num % 2 == 0
        chat.speaker = :user
      else
        chat.speaker = :circle
      end
      p chat.speaker
      chats << chat
    end
    chats
  end

end
