class Feed < ActiveRecord::Base
  has_many :users, through: :subscriptions

end
