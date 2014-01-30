class Post < ActiveRecord::Base
  belongs_to :feed
  validates :posted_at, presence: true
end
