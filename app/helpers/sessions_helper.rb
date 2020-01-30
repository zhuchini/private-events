module SessionsHelper
  def login(user)
    session[:user_id] = user.id
  end

  def logged_in?
    !current_user.nil?
  end

  def current_user
    @current ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
  end

  def current_user?(user)
    user == current_user
  end

  # def require_login
  #   if logged_in?
  #     flash[:warning] = 'You need to be logged in!'
  #     redirect_to root_url
  #   end
  # end
end
