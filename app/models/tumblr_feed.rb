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

  def api_posts
    TumblrFeed.client.posts(self.uid)
  end

  # def save_posts  #consider making validations
  #   posts.each do |post|
  #     Post.create!(#pass in all the stuff from the table you haven't made yet)
  #   end
  # end
end
