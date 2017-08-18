class UsersController < ApplicationController
  before_action :set_user!, only: [:show]
  before_action :is_authenticated?, only: [:show]
  before_action :can_only_view_yourself?, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      redirect_to new_user_path
    end
  end

  def show

  end

  private

  def set_user!
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :password, :nausea, :happiness, :tickets, :height, :admin)
  end

  def can_only_view_yourself?
    unless is_admin? || current_user.id == params[:id].to_i
      redirect_to user_path(current_user)
    end
  end
end