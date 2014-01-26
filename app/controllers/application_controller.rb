class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  # Moved greeting here so that all controllers have access for validations.
  
  def greeting
    if current_user
      current_user.username
    else
      "Potential Stalker"
    end
  end

  helper_method :greeting

end
