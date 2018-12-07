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
    user_blocks_params[:user_ids].each do |user_id|
      UserBlock.create(user_id: user_id, circle_id: params[:circle_id])
    end
    flash[:success] = "指定したユーザーをブロックしました"
    redirect_to action: "new", circle_id: params[:circle_id], activity_id: params[:activity_id]
  end

  private
  def user_blocks_params
    params.permit(user_ids: [])
  end

end
