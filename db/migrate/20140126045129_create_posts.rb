class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :uid
      t.string :type
      t.string :title
      t.string :author
      t.datetime :post_date
      t.text :message
      t.string :url

      t.timestamps
    end
  end
end
