class UsersController < ApplicationController
  before_action :ensure_logged_in, except: [:new, :create]

  def new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      url = "http://localhost:3000/users/activate?activation_token=#{@user.activation_token}"
      msg = UserMailer.welcome_email(@user, url)
      msg.deliver_now
      redirect_to user_url(@user)
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_url
    end
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def activate
    @user = User.find_by(activation_token: params[:activation_token])
    @user.activated = true
    @user.save!
    redirect_to user_url(@user)
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
