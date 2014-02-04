class Feed < ActiveRecord::Base
  has_many  :users, through: :subscriptions
  has_many  :posts
  validates :type, :uid, presence: true
end
