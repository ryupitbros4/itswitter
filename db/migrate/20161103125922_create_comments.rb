class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :restaurant_id
      t.integer :user_id
      t.string :comment
      t.integer :crowdedness
      t.integer :be_liked

      t.timestamps null: false
    end
  end
end
