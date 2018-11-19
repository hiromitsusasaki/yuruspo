class Webapp::SessionsController < ApplicationController
  def create
    user = User.find_or_create_from_auth(request.env['omniauth.auth'])
    session[:user_id] = user.id
    # TODO: login元で遷移先を分ける（UserとCIrcle）
    redirect_to root_path
  end

  def destroy
    reset_session
    # TODO: 
    redirect_to root_path
  end
end