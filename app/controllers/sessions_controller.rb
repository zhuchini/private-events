class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && @user.authenticate(params[:session][:password])
      flash[:success] = "Login Success!"
      redirect_to root_url
    else
      flash[:warning] = "Failed"
      render 'new'
    end
  end

  def destroy
    logout if logged_in?
    flash[:success] = "Logged out."
    redirect_to root_url
  end
end
