class Webapp::ApplicationsController < ApplicationController

  before_action :authenticate

  def create
    application = Application.create(activity_id: params[:activity_id], user_id: current_user.id)
    if params[:is_join_request]
      application.status = :requested
      application.save
      chat = Chat.create(application_id: application.id, speaker: current_user, body: "参加リクエストを送りました")
    end
    redirect_to :action => 'show', :circle_id => application.activity.circle.id, :activity_id => application.activity.id, :application_id => application.id
  end

  def show
    @application = Application.find(params[:application_id])
    @is_blocking_exists = UserBlock.is_blocking_exists(@application.user, @application.activity.circle)
    if current_user == @application.user or current_user == @application.activity.circle.owner
      @chats = Chat.where(application_id: params[:application_id])
      if @application.activity.circle.owner == current_user
        @chats.each do |chat|
          if !chat.is_already_read
            chat.is_already_read = true
            chat.save
          end
        end
      end
    else
      not_found
    end
  end
end
