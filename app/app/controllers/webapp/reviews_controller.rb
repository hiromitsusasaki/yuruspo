class Webapp::ReviewsController < ApplicationController
  before_action :authenticate

  def new
    @activity = Activity.find(params[:activity_id])
    @user = current_user
    # 自分のサークルのレビューページに入りそうだったらその人のサークル詳細ページへリダイレクト
    redirect_to controller: "circles", action: "show", circle_id: @user.owned_circle_id if @activity.circle.owner == @user
  end

  def create
    activity = Activity.find(params[:activity_id])
    review = ActivityReview.new(review_params)
    review.activity = activity
    review.user = current_user
    current_user.update(review_name: params[:user][:review_name])
    if current_user.review_name.present? && review.save
      redirect_to :action => "complete", :circle_id => activity.circle.id, :activity_id => activity.id, :review_id => review.id
    else
      redirect_to :action => 'new', :circle_id => activity.circle.id, :activity_id => activity.id, :flash => {error: 'レビュー登録に失敗しました'}
    end
  end

  def complete
    @activity = Activity.find(params[:activity_id])
    @review = ActivityReview.find(params[:review_id])
    @user = current_user
  end

  private
  def review_params
    params.require('review').permit(:evaluation, :comment)
  end
end
