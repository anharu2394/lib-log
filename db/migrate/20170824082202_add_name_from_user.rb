class AddNameFromUser < ActiveRecord::Migration
  def change
    add_column :users, :token, :string
  end
end
