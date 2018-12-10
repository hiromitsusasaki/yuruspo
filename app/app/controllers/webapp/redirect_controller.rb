class Webapp::RedirectController < ApplicationController
  
  before_action :authenticate, :when_no_circle
  
  def to_owned_circle_show
    redirect_to :controller => "circles", :action => "show", :circle_id => current_user.owned_circle.id
  end

  def to_owned_circle_activities_new
    redirect_to :controller => "activities", :action => "new", :circle_id => current_user.owned_circle.id
  end
end
