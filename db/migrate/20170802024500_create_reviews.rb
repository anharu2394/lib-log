class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :rate
      t.text :text

      t.timestamps null: false
    end
  end
end
