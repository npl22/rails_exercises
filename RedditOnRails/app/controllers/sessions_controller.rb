class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )
    if @user
      login!(@user)
      # TODO: redirect_to
    else
      # needs to be an array so that you can call each on this
      flash[:errors] = ['Invalid login credentials']
      render :new
    end
  end

  def destroy
    logout!
    # TODO: redirect_to
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
