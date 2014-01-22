class AddTableToUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uid
      t.string :provider
      t.string :email
      t.string :avatar_url
      t.string :username
    end
  end
end
