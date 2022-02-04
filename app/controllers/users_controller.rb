class UsersController < ApplicationController
  def show
    if logged_in?
      @user = current_user
    else
      redirect_to login_path
      flash[:danger] = "Log in to see that page"
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App"
      log_in @user
      redirect_to user_url(@user)
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
