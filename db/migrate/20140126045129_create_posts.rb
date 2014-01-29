class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :content_type
      t.string :title
      t.string :author
      t.datetime :post_date
      t.string :url
      t.integer :feed_id
      t.text   :content
     
      t.timestamps
    end
  end
end
