class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, except: [:destroy]
  def new

  end

  def create
    @user = User.find_by(name: params[:user][:name])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:message] = "Invalid combination"
      redirect_to signin_path
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  private

  def redirect_if_logged_in
    if logged_in?
      redirect_to root_path
    end
  end
end