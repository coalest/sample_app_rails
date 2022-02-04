module SessionsHelper

  # Logs in the given user
  def log_in(user)
    session[:user_id] = user.id
  end

  # returns the current user if it exists or finds it by the session id
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by( id: session[:user_id] )
    end
  end

  # returns true if user is logged in, otherwise false
  def logged_in?
    !!current_user
  end

  def log_out(user)
    session.delete(:user_id)
    @current_user = nil
  end
end
