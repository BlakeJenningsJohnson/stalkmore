class RssController < ApplicationController
  require_dependency 'feed'

  def index
  end

  def create
    @new_feed = Rssfeed.new
    @new_feed.uid = current_user
    @new_feed.rss_url = params[:rss_url]
    @new_feed.save

    if @new_feed.save
      redirect_to :root
    else
      render "sessions/show"
    end

  end

 
end