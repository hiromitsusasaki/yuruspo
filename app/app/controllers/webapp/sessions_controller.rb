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
      redirect_to root_path
    when 'circle' then
      p 'login as circle.'
      if user.has_circle
        # サインイン初期登録の場合
        redirect_to :controller => 'circles', :action => 'new'
      else
        #　ログイン（登録済み）の場合
        redirect_to :controller => 'circles', :action => 'show', :circle_id => user.owned_circle.id
      end
    end
  end

  def destroy
    reset_session
    # TODO: 
    redirect_to root_path
  end
end