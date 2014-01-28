class Feed < ActiveRecord::Base
  has_many :users, through: :subscriptions
  has_many :subscriptions
  validates :type, presence: true

end
