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
          :content   => entry.summary.try(:truncate, 340),
          :url       => entry.url,
          :feed_id   => self.id, # where self is this specific RssFeed
          :content_type => "rss"
          )
      end
    end
  end

end 




  