class AddGenderToUserDetails < ActiveRecord::Migration
  def change
    add_column :user_details, :gender, :string
  end
end
