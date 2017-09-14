class AddAgeToUserDetails < ActiveRecord::Migration
  def change
    add_column :user_details, :age, :integer
  end
end
