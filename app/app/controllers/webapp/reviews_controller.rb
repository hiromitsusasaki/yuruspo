class Webapp::ReviewsController < ApplicationController
  before_action :authenticate

  def new
    @activity = Activity.find(params[:activity_id])
    @user = current_user
  end

  def create
    activity = Activity.find(params[:activity_id])
    review = ActivityReview.new(review_params)
    review.activity = activity
    review.user = current_user
    if review.save
      redirect_to :action => "complete", :circle_id => activity.circle.id, :activity_id => activity.id
    else
      redirect_to :action => 'new', :circle_id => activity.circle.id, :activity_id => activity.id, :flash => {error: 'レビュー登録に失敗しました'}
    end
  end

  def complete

  end

  private
  def review_params
    params.require('review').permit(:evaluation, :comment)
  end
end
