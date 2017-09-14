class RemoveTokenFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :refresh_token, :string
    remove_column :users, :access_token, :string
  end
end
