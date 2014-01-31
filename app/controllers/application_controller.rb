class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :check_current_user

  # def set_current_user
  #   @current_user = User.find(session[:user_id]) || User.new
  # end

  def check_current_user
    @current_user ||= User.find(session[:user_id]) 
    # @user = User.new
  rescue ActiveRecord::RecordNotFound
    session[:user_id] = nil
    redirect_to welcome_path
  end
end
