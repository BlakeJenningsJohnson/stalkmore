class TwitterFeed < Feed

  # def get_posts
  #   interact with API
  # end

  def client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
      config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
    end
  end

  def api_posts
    TwitterFeed.client.user_timeline(self.uid.to_i)
  end

  def save_posts #consider making validations
    client.user_timeline(self.uid.to_i).each do |tweet|
      Post.create!(feed_id: id, content: tweet.text, author: tweet.user.name, post_date: tweet.created_at, content_type: "tweet" )
    end  
  end
end
