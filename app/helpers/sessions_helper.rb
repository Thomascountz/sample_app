module SessionsHelper
  
  # Logs in the given user
  def log_in(user)
    session[:user_id] = user.id  
  end
  
  # Remembers the given user in a persistent session cookie
  def remember(user)
    user.remember # Saves an ecrypted remember_token into a User row in the database
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token 
  end
  
  # Returns true if the given user is the current user
  def current_user?
    user == current_user
  end
  
  # Returns the current logged-in user (if any)
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
  
  # Returns true if a user is logged in, returns false otherwise
  def logged_in?
    !current_user.nil?
  end
  
  # Forgets a presistent session
  def forget(user)
    user.forget # Sets a User's remember_token to nil in the database
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
  
  # Logs out the current user
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
end
