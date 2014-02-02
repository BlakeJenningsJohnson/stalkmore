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

  #def self.api_posts(thing_to_follow)
    #self.client.posts(thing_to_follow)
  #end
  #search method in feedcontroller

  def api_posts #self.api_posts()
    #TumblrFeed.api_posts(self.uid)
    TumblrFeed.client.posts(self.uid)
  end

  def save_posts  #consider making validations
    temp_post_hash = api_posts["posts"]
    temp_post_hash.each do |tu_post|
      next if Post.find_by_url(tu_post["post_url"])

      tumble = Post.new(  feed_id:    id, 
                          author:     tu_post["blog_name"], 
                          post_date:  tu_post["date"], 
                          url:        tu_post["post_url"],
                          content_type: "tumble"
                          )
      if  tu_post["type"] == "text" || tu_post["type"] == "chat"
          tumble.content = tu_post["body"]
          tumble.title   = tu_post["title"].try(:truncate, 240)
      elsif tu_post["type"] == "photo" 
          tumble.content = tu_post["photos"].map {|photo| "<img src=#{photo["alt_sizes"][1]["url"]}>"}.join
          tumble.title   = tu_post["caption"].try(:truncate, 240)
      elsif tu_post["type"] == "quote"
          tumble.content = tu_post["source"]
          tumble.title   = tu_post["text"].try(:truncate, 240)
      elsif tu_post["type"] == "audio"
          tumble.content = tu_post["embed"]
          tumble.title   = tu_post["track_name"].try(:truncate, 240)
      elsif tu_post["type"] == "video"
          tumble.content = tu_post["player"][2]["embed_code"]
          tumble.title  = tu_post["caption"].try(:truncate, 240)
      elsif tu_post["type"] == "quote"
          tumble.content = tu_post["body"].try(:truncate, 240)
          tumble.title  = tu_post["source"].try(:truncate, 240)
      elsif tu_post["type"] == "answer"
          tumble.content = tu_post["answer"].try(:truncate, 240)
          tumble.title  = tu_post["question"].try(:truncate, 240)
      end
      tumble.save
    end
  end
end
