class User < ActiveRecord::Base
  has_many :subscriptions
  has_many :feeds, through: :subscriptions
  has_many :posts, through: :feeds

  validates  :username, :uid, :provider, presence: true

  def self.find_or_create_from_omniauth(auth_hash)
    User.find_by(uid: auth_hash["uid"]) || create_from_omniauth(auth_hash)
    @user = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
      config.access_token        = auth_hash["credentials"]["token"]
      config.access_token_secret = auth_hash["credentials"]["secret"]
    end
    @user.update(access_token:         auth_hash["credentials"]["token"],
                 access_token_secret:  auth_hash["credentials"]["secret"])
  end

  def self.create_from_omniauth(auth_hash)
    self.create!(
      uid:                  auth_hash["uid"],
      provider:             auth_hash["provider"],
      avatar_url:           auth_hash["info"]["image"],
      username:             auth_hash["info"]["nickname"],
      access_token:         auth_hash["credentials"]["token"],
      access_token_secret:  auth_hash["credentials"]["secret"]
    )

  rescue ActiveRecord::RecordInvalid
    nil
  end


end




