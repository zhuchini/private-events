module SessionsHelper
  def logged_in?
    !current_user.nil?
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

  def logout
    session[:user_id] = nil
  end

  def require_login
    return unless !logged_in?
  
    flash[:warning] = 'You need to be logged in!'
    redirect_to root_url
  end
end
