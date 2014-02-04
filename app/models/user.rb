class User < ActiveRecord::Base
  has_many :subscriptions
  has_many :feeds, through: :subscriptions
  has_many :posts, through: :feeds

  validates  :username, :uid, :provider, presence: true

  def self.find_or_create_from_omniauth(auth_hash)
    user = User.find_by(uid: auth_hash["uid"]) || create_from_omniauth(auth_hash)
    return unless user
    user.update(access_token:         auth_hash["credentials"]["token"],
                access_token_secret:  auth_hash["credentials"]["secret"])
    user
  end

  def self.create_from_omniauth(auth_hash)
    user = self.create(
      uid:                  auth_hash["uid"],
      provider:             auth_hash["provider"],
      avatar_url:           auth_hash["info"]["image"],
      username:             auth_hash["info"]["nickname"],
      access_token:         auth_hash["credentials"]["token"],
      access_token_secret:  auth_hash["credentials"]["secret"]
    )
    if user.valid? 
      user
    else
      nil
    end
  end

  def tweet(tweet_body)
    user_client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
      config.access_token        = self.access_token
      config.access_token_secret = self.access_token_secret
    end
    user_client.update(tweet_body)
  end

  def homefeed
    @users_client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
      config.access_token        = self.access_token
      config.access_token_secret = self.access_token_secret
    end

    @users_client.home_timeline.each do |post|
      Post.find_or_create_by(
                  feed_id: id,
                  content: post.text,
                  author: post.user.screen_name,
                  post_date: post.created_at,
                  content_type: "tweet",
                  url: post.url.to_s)
    end
  end
end




