class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :login, :logged_in?, :current_user, :logout, :current_user?

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
end
