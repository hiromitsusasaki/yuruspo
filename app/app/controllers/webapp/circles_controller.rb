class Webapp::CirclesController < ApplicationController
  
  before_action :authenticate
  
  def new
    @contents = sport_contents
  end

  def create
    ActiveRecord::Base.transaction do
      circle = Circle.new(circle_params)
      circle.owner = current_user
      circle.save!
      current_user.save!
      params[:content_ids].each do |content_id|
        circle_content = CircleContent.new
        circle_content.circle = circle
        circle_content.content = Content.find(content_id)
        circle_content.save!
      end
      flash[:success] = "サークル情報を登録しました"
      redirect_to action: 'show', circle_id: circle.id
    end
  rescue
    flash[:warning] = "サークル情報の登録に失敗しました"
    redirect_to action: 'new'
  end

  def show
    @circle = Circle.find(params[:circle_id])
  end

  def edit
    @circle = Circle.find(params[:circle_id])
    @contents = sport_contents
  end

  def update
    ActiveRecord::Base.transaction do
      circle = Circle.find(params[:circle_id])
      circle.circle_contents.destroy_all
      params[:content_ids].each do |content_id|
        circle_content = CircleContent.new
        circle_content.circle = circle
        circle_content.content = Content.find(content_id)
        circle_content.save
      end
      circle.update(circle_params)
      flash[:success] = "サークル情報を編集しました"
      redirect_to action: 'show', circle_id: circle.id
    end
  rescue
    flash[:warning] = "サークル情報の編集に失敗しました"
    redirect_to  action: 'edit', circle_id: circle.id
  end

  private
  def circle_params
    params.require(:circle).permit(:name, :introduction, :default_auto_reply_comment)
  end

  def sport_contents
    EventType.find_by(name: 'スポーツ').contents
  end
end
