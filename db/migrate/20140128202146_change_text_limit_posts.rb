class ChangeTextLimitPosts < ActiveRecord::Migration
  def change
    change_column :posts, :content, :text, limit: 104857600
  end
end
