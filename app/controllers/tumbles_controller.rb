class TumblesController < ApplicationController

  def search
    Tumblr.configure do |config|
      config.consumer_key = ENV["TUMBLR_KEY"]
      config.consumer_secret = ENV["TUMBLR_SECRET"]
      config.oauth_token = ENV["TUMBLR_OAUTH_ACCESS_TOKEN"]
      config.oauth_token_secret = ENV["TUMBLR_OAUTH_SECRET_TOKEN"]
    end

    client = Tumblr::Client.new
    @tumbles = client.posts(params[:search])
  end
end
