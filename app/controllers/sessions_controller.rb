class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token


  def show
    if current_user 
      @feeds = current_user.feeds
      @all_the_posts = current_user.posts.order('post_date DESC')
    else 
      redirect_to "home"
    end
  end

  def index
  end

  def create
    auth_hash = request.env['omniauth.auth']
    if auth_hash["uid"]
      @user = User.find_or_create_from_omniauth(auth_hash)
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

  def sign_out
    session[:user_id] = nil
    redirect_to "/", notice: "You have been successfully signed out."
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
  
end