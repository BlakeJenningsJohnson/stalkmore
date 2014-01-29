class FeedsController < ApplicationController

  def new
  end

  def create
    @feed = Feed.find_or_create_by(uid: params["uid"], type: params["type"])  #views have to pass in type
    @subscription = Subscription.find_or_create_by(user_id: current_user.id, feed_id: @feed.id)
    if @feed.save! && @subscription.save!
      @feed.save_posts
      redirect_to "/", notice: "A new person to stalk! Look!"
    else
      redirect_to "/", notice: "There was a problem adding this user."
    end
  end
end
