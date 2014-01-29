class TwitterFeed < Feed

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

  def save_posts #consider making validations and a find or create by method to eliminate feed duplication bug
    client.user_timeline(self.uid.to_i).each do |tweet|
      Post.create!(
        feed_id: id, 
        content: tweet.text, 
        author: tweet.user.name, 
        post_date: tweet.created_at, 
        content_type: "tweet" 
        )
    end  
  end
end
