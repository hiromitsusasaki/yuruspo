class ApplicationController < ActionController::Base

  layout "webapp/layouts/application.html.erb"

  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  private

  def current_user
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end

  def logged_in?
    !!session[:user_id]
  end

  def authenticate
    session[:previous_url] = request.url
    return if logged_in?
    redirect_to root_path
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
