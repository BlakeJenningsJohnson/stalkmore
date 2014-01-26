class Rssfeed < Feed
  require 'feedzirra'
  validate :valid_feed
  
  def valid_feed
    if Feedzirra::Feed.fetch_and_parse(self.rss_url).class == Fixnum
      errors.add(:rss_url, "Invalid feed URL. Please try again.")
    end
  end

  def update_posts
    feed = Feedzirra::Feed.fetch_and_parse(self.rss_url)
    feed.sanitize_entries!
    feed.entries.each do | entry |
      if Post.where("title = ? AND post_date = ?", entry.title, entry.published).count == 0

        Post.create!(
          # :uid 
          # :type  
          :title     => entry.title,
          :author    => entry.author, 
          :post_date => entry.published,
          :message   => entry.summary,
          :url       => entry.url
          )
      end
    end
  end

end
  