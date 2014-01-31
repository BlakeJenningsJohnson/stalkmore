class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :check_current_user

  def welcome
  end

  def index
  end

  def create
    auth_hash = request.env['omniauth.auth']
    if auth_hash["uid"]
      @user = User.find_or_create_from_omniauth(auth_hash)
      @user.update(access_token:         auth_hash["credentials"]["token"],
                   access_token_secret:  auth_hash["credentials"]["secret"])
      if @user
        session[:user_id] = @user.id
        redirect_to "/", notice: "You have been successfully signed in."
      else
        redirect_to "/", notice: "Failed to save user."
      end
    else
      redirect_to "/", notice: "Failed to authenticate. Please try a dragon."
    end
  end

  def sign_in
    redirect_to "/auth/twitter"
  end

  def sign_out
    session[:user_id] = nil
    redirect_to "/", notice: "You have been successfully signed out."
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
  
end