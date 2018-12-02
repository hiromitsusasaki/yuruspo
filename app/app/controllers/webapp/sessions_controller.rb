class Webapp::SessionsController < ApplicationController
  
    before_action :authenticate, only: [:destroy]
  
  def create
    user = User.find_or_create_from_auth(request.env['omniauth.auth'])
    session[:user_id] = user.id
    login_as = session[:login_as]
    previous_url = session[:previous_url]
    session[:login_as] = nil
    session[:previous_url] = nil
    if previous_url
      redirect_to previous_url
    else
      case login_as 
      when 'user' then
        redirect_to :controller => 'users', :action => 'loggedin_as_user'
      when 'circle' then
        if user.has_circle?
          #　ログイン（登録済み）の場合
          redirect_to :controller => 'circles', :action => 'show', :circle_id => user.owned_circle.id
        else
          # サインイン初期登録の場合
          redirect_to :controller => 'circles', :action => 'new'
        end
      end
    end
  end

  def login_by_user_id
    user = User.find(params.require('user').permit(:id)[:id])
    session[:user_id] = user.id
    redirect_to :controller => 'users', :action => 'loggedin_as_user'
  end

  def destroy

    reset_session
    # TODO: 
    redirect_to root_path
  end
end