class Webapp::SessionsController < ApplicationController
  def create
    user = User.find_or_create_from_auth(request.env['omniauth.auth'])
    session[:user_id] = user.id
    login_as = session[:login_as] 
    session.delete(:login_from)
    case login_as 
    when 'user' then
      # userでログインした場合の処理
      p 'login as user.'
    when 'circle' then
      # circleでログインした場合の処理
      p 'login as circle.'
    end
    
    redirect_to root_path
  end

  def destroy
    reset_session
    # TODO: 
    redirect_to root_path
  end
end