class CreateUserDetails < ActiveRecord::Migration
  def change
    create_table :user_details do |t|
      t.text :profile

      t.timestamps null: false
    end
  end
end
