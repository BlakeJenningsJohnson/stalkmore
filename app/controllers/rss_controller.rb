class RssController < ApplicationController
  require_dependency 'feed'

  def index
  end

  def search
    @rss_feed = Feedzirra::Feed.fetch_and_parse(params[:uid])
  end

  def create
    @new_feed = Rssfeed.create(uid: params[:uid], type: params[:type])  # type isn't needed because when feed is saved, type is automatically included.
  
    if @new_feed.save
      @new_feed.save_posts
      # subscription.create!(feed_id: @new_feed.id, user_id: current_user.id)
      redirect_to :root
    else
      render "sessions/show"
    end
  end
end

 # def create
  #   @new_feed = Rssfeed.new
  #   @new_feed.uid = current_user
  #   @new_feed.rss_url = params[:rss_url]

  #   if @new_feed.save
  #     @new_feed.update_posts
  #     redirect_to :root
  #   else
  #     render "sessions/show"
  #   end
  # end