class AddOmniauthToUsers < ActiveRecord::Migration
  def change
        add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :name, :string
    add_column :users, :refresh_token, :string
    add_column :users, :access_token, :string
  end
end
