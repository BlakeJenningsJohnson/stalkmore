class RemoveProviderFromFeed < ActiveRecord::Migration
  def change
    remove_column :feeds, :provider
  end
end
