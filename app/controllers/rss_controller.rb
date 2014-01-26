class RssController < ApplicationController
  require_dependency 'feed'

  def index
  end

  def create
    @new_feed = Rssfeed.new
    @new_feed.uid = current_user
    @new_feed.rss_url = params[:rss_url]

    if @new_feed.save
      @new_feed.update_posts
      redirect_to :root
    else
      render "sessions/show"
    end

  end

 
end