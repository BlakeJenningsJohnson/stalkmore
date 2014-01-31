class TwitterController < ApplicationController

  def index
  end

  def search
    @users = TwitterFeed.client.user_search(params[:user_name])
    if @users.empty?
      redirect_to "/", notice: "No match found.  <a onclick=\"textBoxFocus('user_name')\">Please search again.</a>".html_safe 
    end
  end

  def posttweet
    if params[:tweet_body] && params[:tweet_body].size < 140
      @current_user.tweet(params[:tweet_body])
      redirect_to "/", notice: "Tweet posted: #{params[:tweet_body]} "
    else
      redirect_to "/", notice: "Invalid tweet.  <a onclick=\"textBoxFocus('posttweet')\">Please try again.</a>".html_safe 
    end
  end
end

