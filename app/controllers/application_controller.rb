class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :check_current_user
  before_action :require_current_user


  def check_current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  rescue ActiveRecord::RecordNotFound
    session[:user_id] = nil
    redirect_to welcome_path
  end


  def require_current_user
    if check_current_user.nil?
      redirect_to welcome_path, notice: "You have to sign in to do that."
    end
  end
end
