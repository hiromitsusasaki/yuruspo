class Webapp::UserBlocksController < ApplicationController
  before_action :authenticate

  def new
    @activity = Activity.find(params[:activity_id])
    user_blocks = UserBlock.where(circle_id: params[:circle_id])
    @blocked_users = Array.new
    user_blocks.each do |user_block|
      @blocked_users << user_block.user
    end
  end

  def create
    p request.referer
    p params
    p referer = Rails.application.routes.recognize_path(request.referer)
    if referer[:controller] == "webapp/applications" and referer[:action] == "show"
      UserBlock.create(user_id: params[:user_id], circle_id: params[:circle_id])
      redirect_to controller: 'applications', action: 'show', circle_id: referer[:circle_id], \
        activity_id: referer[:activity_id], application_id: referer[:application_id]
    else
      user_blocks_params[:user_ids].each do |user_id|
        UserBlock.create(user_id: user_id, circle_id: params[:circle_id])
      end
      flash[:success] = "指定したユーザーをブロックしました"
      redirect_to action: "new", circle_id: params[:circle_id], activity_id: params[:activity_id]
    end
  end

  private
  def user_blocks_params
    params.permit(user_ids: [])
  end

end
