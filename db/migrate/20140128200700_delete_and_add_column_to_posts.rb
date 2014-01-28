class DeleteAndAddColumnToPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :content
    add_column :posts, :content, :text, limit: 100.megabytes
  end
end
