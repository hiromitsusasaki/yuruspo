class Webapp::UserBlocksController < ApplicationController
  before_action :authenticate

  def new
    @activity = Activity.find(params[:activity_id])
  end

end
