class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :is_admin?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user
  end

  def is_authenticated?
    if !logged_in?
      flash[:message] = 'You must be logged in to view this content'
      redirect_to root_path
    end
  end

  def is_admin?
    current_user && current_user.admin
  end
end
