class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !current_user.nil?
  end

  def log_in_user!(user)
      session[:session_token] = user.reset_session_token!
  end

  def ensure_logged_in
    unless logged_in?
      redirect_to new_session_url
    end
  end

  def ensure_activated
    unless current_user.activated
      flash[:errors] = "Account not activated, check your e-mail!!"
      redirect_to new_session_url
    end
  end
end
