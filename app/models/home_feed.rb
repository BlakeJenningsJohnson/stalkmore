# class TwitterFeed < Feed

#   def self.client
#     Twitter::REST::Client.new do |config|
#       config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
#       config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
#       config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
#       config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
#     end
#   end

#   def savepost
#     TwitterFeed.client.home_timeline.each do |tweet|
#     @users_client = Twitter::REST::Client.new do |config|
#       config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
#       config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
#       config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
#       config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
#     end

#     # @users_client.home_timeline.each do |post|
#     #   Post.create(
#     #               feed_id: id,
#     #               content: post.text,
#     #               author: post.user.screen_name,
#     #               post_date: tweet.created_at,
#     #               content_type: "tweet",
#     #               url: post.url.to_s
#     # end
#   end
# end