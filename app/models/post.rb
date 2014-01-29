class Post < ActiveRecord::Base
  belongs_to :feed
  # validates :post_date, presence: true, uniqueness: true

end
