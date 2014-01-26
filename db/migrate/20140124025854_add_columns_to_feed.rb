class AddColumnsToFeed < ActiveRecord::Migration
  def change
    add_column :feeds, :uid, :string
    add_column :feeds, :provider, :string
    add_column :feeds, :type, :string
    add_column :feeds, :rss_url, :string
  end
end
