class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  helper_method :current_user, :logged_in?
  
  def login(user)
    session[:session_token] = user.reset_session_token!
    @current_user = user
    redirect_to subs_url
  end
  
  def current_user
    @current_user ||= User.find_by(session: session[:session_token])
  end
  
  def logout!
    self.reset_session_token!
    session[:session_token] = nil
  end
  
  def logged_in?
    !!current_user
  end
  
  def require_login
    redirect_to new_session_url unless logged_in?
  end
end
