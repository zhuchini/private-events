class SessionsController < ApplicationController
  def new; end

  def create
    if user = User.find_by(email: params[:session][:email])
      login(user)
      flash[:success] = 'Login Success!'
      redirect_to user_path(@user)
    else
      flash[:warning] = 'Failed.'
      render 'new'
    end
  end

  def destroy
    logout if logged_in?
    flash[:success] = 'Logged out.'
    redirect_to root_url
  end

  private

  # def login_params
  #   params.require(:login).permit(:email)
  # end
end
