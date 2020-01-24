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
    if !logged_in?
      flash[:warning] = "You should be logged in for this action!"
      redirect_to root_url
    end
  end
end
