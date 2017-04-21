class SessionsController < ApplicationController
  before_action :ensure_logged_in, except: [:new, :create, :destroy]
  before_action :ensure_activated, except: [:new, :create, :destroy]
  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:email], params[:user][:password])
    if @user
      log_in_user!(@user)
      redirect_to user_url(@user)
    else
      flash[:errors] = 'Email or password not valid'
      redirect_to new_session_url
    end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url #TODO: redirect to home page
  end


end
