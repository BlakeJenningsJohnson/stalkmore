class FeedsController < ApplicationController

  def new
  end

  # def tweet_show
  #   @all_tweets = @feeds.each do |feed|
  #     raise
  #     puts feed.user_timeline.inspect
  #   end
  # end

  def create
    @feed = Feed.find_or_create_by(uid: params["uid"], type: "TwitterFeed") # 
    @subscription = Subscription.new(user_id: current_user.id, feed_id: @feed.id)
    if @feed.save! && @subscription.save!
      redirect_to "/", notice: "A new person to stalk! Look!"
    else
      redirect_to "/", notice: "There was a problem adding this user."
    end
  end
end

# 2.0.0p247 :048 > client.user_timeline(14627400).each do |t|
# 2.0.0p247 :049 >     puts t.user
# 2.0.0p247 :050?>   puts t.text
# 2.0.0p247 :051?>   end