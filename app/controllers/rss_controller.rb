class RssController < ApplicationController
  require_dependency 'feed'

  def index
  end

  def search
    @rss_feed = Feedzirra::Feed.fetch_and_parse(params[:uid].strip)
  end

end

