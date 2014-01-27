class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    if current_user
      @feeds = current_user.feeds
      @all_tweets = @feeds.map do |feed|
        feed.posts
      end
    else 
      redirect_to sign_in_path
    end
  end

  def index
  end

  def create
    @user = User.find_or_create_from_omniauth(auth_hash)
    session[:user_id] = @user.id
    redirect_to "/", notice: "You have been successfully signed in."
  end

  def sign_out
    session[:user_id] = nil
    redirect_to "/", notice: "You have been successfully signed out."
  end

  def greeting
    if current_user
      current_user.username
    else
      "Potential Stalker"
    end
  end

  helper_method :greeting

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end