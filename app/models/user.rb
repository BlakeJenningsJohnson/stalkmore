class User < ActiveRecord::Base
  has_many :subscriptions
  has_many :feeds, through: :subscriptions
  has_many :posts, through: :feeds

  validates :email, :username, :uid, :provider, presence: true

  def self.find_or_create_from_omniauth(auth_hash)
    User.find_by(uid: auth_hash["uid"]) || create_from_omniauth(auth_hash)
  end

  # def posts
  #   posts = []
    
  #   feeds.each do |feed|
  #     feed.posts.each do |post|
  #       posts << post
  #     end
  #   end

  #   posts
  # end


  def self.create_with_omniauth(auth_hash)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["nickname"]
      user.avatar = auth["info"]["image"]
    end
  end
end

  def self.create_from_omniauth(auth_hash)
    self.create!(
      uid:        auth_hash["uid"],
      provider:   auth_hash["provider"],
      email:      auth_hash["info"]["email"],
      avatar_url: auth_hash["info"]["image"],
      username:   auth_hash["info"]["name"]
    )

  rescue ActiveRecord::RecordInvalid
    nil
  end
end