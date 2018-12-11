class Webapp::MessagesController < ApplicationController

  before_action :authenticate

  def create
    ActiveRecord::Base.transaction do
      activity = Activity.find(params[:activity_id])
      message = Message.create(message_params)
      message.activity = activity
      message.save
      activity.users.each do |user|
        messages = [{type: 'text', text: message.body}]
        ::LineBot::ForUser::PushWorker.perform_async(user.line_user_id, messages)
      end
      flash[:success] = "メッセージを送信しました"
      redirect_to :controller => 'activities', :action => 'show', :circle_id => activity.circle.id, :activity_id => activity.id
    end
  rescue
    flash[:success] = "メッセージの送信に失敗しました"
    redirect_to :controller => 'activities', :action => 'show', :circle_id => activity.circle.id, :activity_id => activity.id
  end

  private
  
  def message_params
    params.require('message').permit(:body)
  end

end
