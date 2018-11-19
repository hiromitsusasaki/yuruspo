class Webapp::UsersController < ApplicationController

  def login_as_user
    session[:login_as] = "user"
  end

  def login_as_circle
    session[:login_as] = "circle"
  end

end
