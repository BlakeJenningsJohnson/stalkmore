class Rssfeed < Feed
  require 'feedzirra'
  validate :valid_feed
  
  def valid_feed
    if Feedzirra::Feed.fetch_and_parse(self.rss_url).class == Fixnum
      errors.add(:rss_url, "Invalid feed URL. Please try again.")
    end
  end

  def get_posts
    Feedzirra::Feed.fetch_and_parse(self.rss_url)

  end

end
  