class TwitterController < ApplicationController
  before_action :setup_client
  before_action :set_user

  attr_accessor :access_token, :access_token_secret

  def index
  end

  def search
    @users = @client.user_search(params[:user_name])
    if @users.empty?
      redirect_to "/", notice: "No match found.  <a onclick=\"textBoxFocus('user_name')\">Please search again.</a>".html_safe 
    end
  end

  def posttweet
    if params[:posttweet] && params[:posttweet].size < 140
      @user.update(params[:posttweet])
      redirect_to "/", notice: "Tweet posted: #{params[:posttweet]} "
    else
      redirect_to "/", notice: "Invalid tweet.  <a onclick=\"textBoxFocus('posttweet')\">Please try again.</a>".html_safe 
    end
  end


  private

  def set_user
    @user = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
      config.access_token        = access_token
      config.access_token_secret = access_token_secret
    end
  end

  def setup_client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
      config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
    end
  end

end

