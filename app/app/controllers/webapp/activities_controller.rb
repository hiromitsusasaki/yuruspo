class Webapp::ActivitiesController < ApplicationController
  
  def new
    @circle = Circle.find(params[:circle_id])
  end

end
