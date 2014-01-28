class AddColumnContent < ActiveRecord::Migration
  def change
    add_column :posts, :content, :text, limit: 100.megabytes
  end
end
