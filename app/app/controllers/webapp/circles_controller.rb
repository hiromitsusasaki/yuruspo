class Webapp::CirclesController < ApplicationController
  
  before_action :authenticate
  
  def new
    @contents = EventType.find_by(name: 'スポーツ').contents
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

  private
  def circle_params
    params.require(:circle).permit(:name, :introduction, :default_auto_reply_comment)
  end
end
