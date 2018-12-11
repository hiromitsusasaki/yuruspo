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
    p referer = Rails.application.routes.recognize_path(request.referer)
    if referer[:controller] == "webapp/applications" and referer[:action] == "show"
      if UserBlock.create(user_id: params[:user_id], circle_id: params[:circle_id])
        flash[:success] = "指定したユーザーをブロックしました"
        redirect_to controller: 'applications', action: 'show', circle_id: referer[:circle_id], \
          activity_id: referer[:activity_id], application_id: referer[:application_id]
      else
        flash[:warning] = "指定したユーザーのブロックに失敗しました"
        redirect_to controller: 'applications', action: 'show', circle_id: referer[:circle_id], \
          activity_id: referer[:activity_id], application_id: referer[:application_id]
      end
    else
      ActiveRecord::Base.transaction do
        user_blocks_params[:user_ids].each do |user_id|
          UserBlock.create(user_id: user_id, circle_id: params[:circle_id])
        end
        flash[:success] = "指定したユーザーをブロックしました"
        redirect_to action: "new", circle_id: params[:circle_id], activity_id: params[:activity_id]
      end
    end
  rescue
    flash[:warning] = "指定したユーザーのブロックに失敗しました"
    redirect_to action: "new", circle_id: params[:circle_id], activity_id: params[:activity_id]
  end

  private
  def user_blocks_params
    params.permit(user_ids: [])
  end

end
