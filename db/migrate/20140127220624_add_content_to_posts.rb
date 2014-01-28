class AddContentToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :content_type, :string
    add_column :posts, :title, :string
    add_column :posts, :author, :string
    add_column :posts, :post_date, :datetime
    add_column :posts, :content, :text
    add_column :posts, :url, :string
    add_column :posts, :feed_id, :integer
  end
end


