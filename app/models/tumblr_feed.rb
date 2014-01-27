class TumblrFeed < Feed

  # def get_posts
  #   interact with API
  # end

  def self.client
    Tumblr.configure do |config|
      config.consumer_key = ENV["TUMBLR_KEY"]
      config.consumer_secret = ENV["TUMBLR_SECRET"]
      config.oauth_token = ENV["TUMBLR_OAUTH_ACCESS_TOKEN"]
      config.oauth_token_secret = ENV["TUMBLR_OAUTH_SECRET_TOKEN"]
    end
    client = Tumblr::Client.new
  end
end
