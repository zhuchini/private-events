class UsersController < ApplicationController
  before_action :redirect_if_logged_in, only: %i[new]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      flash[:success] = 'Account Created!'
      redirect_to @user
    else
      flash[:notice] = 'Invalid Credentials'
      render 'new'
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    @upcoming_events = @user.upcoming_events
    @previous_events = @user.previous_events
  end

  private

  def redirect_if_logged_in
    redirect_to user_path(current_user) if logged_in?
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
