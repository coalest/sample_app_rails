class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: login_params[:email].downcase)
    if user&.authenticate(login_params[:password])
      log_in user
      redirect_to user
    else
      flash.now[:danger] = "Invalid credentials"
      render :new
    end
  end

  def delete
    log_out(current_user)
    redirect_to root_url
  end

  private

  def login_params
    params.require(:session).permit(:email, :password)
  end
end
