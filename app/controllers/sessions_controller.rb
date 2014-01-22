class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def show
    @user = User.find(session[:user_id])
  end

  def create
    @user = User.find_or_create_from_omniauth(auth_hash)
    session[:user_id] = @user.id

    redirect_to "/"
  end

  protected


  def auth_hash
    request.env['omniauth.auth']
  end
end