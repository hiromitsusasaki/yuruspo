class Webapp::UsersController < ApplicationController

  before_action :authenticate, only: [:loggedin_as_user]

  def login_as_user
    session[:login_as] = "user"
  end

  def login_as_circle
    session[:login_as] = "circle"
  end

  def loggedin_as_user
    
  end

end
