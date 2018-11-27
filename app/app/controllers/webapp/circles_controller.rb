class Webapp::CirclesController < ApplicationController
  
  before_action :authenticate
  
  def new
    @contents = sport_contents
  end

  def create
    circle = Circle.new(circle_params)
    circle.owner = current_user
    circle.save
    params[:content_ids].each do |content_id|
      circle_content = CircleContent.new
      circle_content.circle = circle
      circle_content.content = Content.find(content_id)
      circle_content.save
    end
    redirect_to :action => 'show', :circle_id => circle.id
  end

  def show
    @circle = Circle.find(params[:circle_id])
  end

  def edit
    @circle = Circle.find(params[:circle_id])
    @contents = sport_contents
  end

  def update
    circle = Circle.update(circle_params)[0]
    circle.circle_contents.destroy_all
    params[:content_ids].each do |content_id|
      circle_content = CircleContent.new
      circle_content.circle = circle
      circle_content.content = Content.find(content_id)
      circle_content.save
    end
    redirect_to :action => 'show', :circle_id => circle.id
  end

  private
  def circle_params
    params.require(:circle).permit(:name, :introduction, :default_auto_reply_comment)
  end

  def sport_contents
    EventType.find_by(name: 'スポーツ').contents
  end
end
