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

  def save_posts  #consider making validations
    temp_post_hash = api_posts["posts"]
    temp_post_hash.each do |tu_post|
      tumble = Post.new(  feed_id:    id, 
                          author:     tu_post["blog_name"], 
                          post_date:  tu_post["date"], 
                          url:        tu_post["post_url"])
      if    tu_post["type"] == "text"
          tumble.content = tu_post["body"]
          tumble.title   = tu_post["title"]
      elsif tu_post["type"] == "photo" 
          tumble.content = tu_post["photos"].map {|photo| "<img src=#{photo["alt_sizes"][1]["url"]}>"}.join
          tumble.title   = tu_post["caption"]
      elsif tu_post["type"] == "quote"
          tumble.content = tu_post["source"]
          tumble.title   = tu_post["text"]
      elsif tu_post["type"] == "audio"
          tumble.content = tu_post["embed"]
          tumble.title   = "track_name"
      end
      tumble.save!
    end
  end
end


  #   posts.each do |tu_feed|
        #tu_feed["posts"]
  #     Post.create!(feed_id: id, #pass in all the stuff from the table you haven't made yet)
  #   end
  # end


# +  def save_posts #consider making validations
#  +    client.user_timeline(self.uid.to_i).each do |tweet|
#  +      Post.create!(feed_id: id, content: tweet.text, author: tweet.user.name, post_date: tweet.created_at, content_type: "tweet" )
#  +    end  
#  +  end
#   create_table "posts", force: true do |t|
#    t.datetime "created_at"
#    t.datetime "updated_at"
#    t.string   "content_type"
#    t.string   "title"
#    t.string   "author"
#    t.datetime "post_date"
#    t.text     "content"
#    t.string   "url"
#    t.integer  "feed_id"
#  end