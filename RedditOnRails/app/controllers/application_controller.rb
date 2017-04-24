class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :signed_in?

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def signed_in?
    !!current_user
  end

  def login!(user)
    session[:session_token] = user.reset_session_token!
  end

  def logout!
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  private

  def require_signed_in
    unless current_user
      redirect_to new_session_url
      flash[:errors] = ['Please log in first']
    end
  end

  def require_moderator
    sub = Sub.find(params[:id])
    unless current_user == sub.moderator
      redirect_to sub_url(sub)
      flash[:errors] =
        ['You must be logged in as the moderator to edit that sub']
    end
  end
end
