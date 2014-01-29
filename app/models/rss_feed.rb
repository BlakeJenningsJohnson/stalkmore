class RssFeed < Feed
  require 'feedzirra'
  validate :valid_feed
  
  def valid_feed
    if Feedzirra::Feed.fetch_and_parse(self.uid).class == Fixnum
      errors.add(:uid, "Invalid feed URL. Please try again.")
    end
  end

  def api_posts
    Feedzirra::Feed.fetch_and_parse(self.uid).entries
  end

  def save_posts
  
    api_posts.each do | entry |
      if Post.where("title = ? AND post_date = ?", entry.title, entry.published).count == 0

        Post.create!( 
          :title     => entry.title,
          :author    => entry.author, 
          :post_date => entry.published,
          :content   => entry.summary,
          :url       => entry.url,
          :feed_id   => self.id, # where self is this specific RssFeed
          :content_type => "rss"
          )
      end
    end
  end

end 
#   def save_posts
#     feed = Feedzirra::Feed.fetch_and_parse(self.uid)
#     feed.sanitize_entries!
#     feed.entries.each do | entry |
#       if Post.where("title = ? AND post_date = ?", entry.title, entry.published).count == 0

#         Post.create!( 
#           :title     => entry.title,
#           :author    => entry.author, 
#           :post_date => entry.published,
#           :content   => entry.summary,
#           :url       => entry.url,
#           :feed_id   => self.id # where self is this specific RssFeed
#           # :content_type => "rss"
#           )
#       end
#     end
#   end

#    def save_posts  #consider making validations
#     temp_post_hash = api_posts["posts"]
#     temp_post_hash.each do | rss_feed |
#       tumble = Post.new(  feed_id:    id, 
#                           author:     tu_post["blog_name"], 
#                           post_date:  tu_post["date"], 
#                           url:        tu_post["post_url"])
#       if    tu_post["type"] == "text"
#           tumble.content = tu_post["body"]
#           tumble.title   = tu_post["title"]
#       elsif tu_post["type"] == "photo" 
#           tumble.content = tu_post["photos"].map {|photo| "<img src=#{photo["alt_sizes"][0]["url"]}>"}.join
#           tumble.title   = tu_post["source_title"]
#       elsif tu_post["type"] == "quote"
#           tumble.content = tu_post["source"]
#           tumble.title   = tu_post["text"]
#       elsif tu_post["type"] == "audio"
#           tumble.content = tu_post["embed"]
#           tumble.title   = "track_name"
#       end
#       tumble.save!
#     end
#   end

# end




  