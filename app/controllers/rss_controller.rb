class RssController < ApplicationController
  require_dependency 'feed'

  def index
  end

  def search
    @rss_feed = Feedzirra::Feed.fetch_and_parse(params[:rss_url])

  end

  def create
    @new_feed = Rssfeed.create(uid: params[:rss_url], type: params[:type])
  
    if @new_feed.save
      redirect_to :root
    else
      render "sessions/show"
    end
  end
end



#   def create
#     @new_feed = Rssfeed.new
#     @new_feed.uid = current_user
#     @new_feed.rss_url = params[:rss_url]

#     if @new_feed.save
#       @new_feed.update_posts
#       redirect_to :root
#     else
#       render "sessions/show"
#     end

#   end
# end
 
