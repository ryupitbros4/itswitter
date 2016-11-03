class CreatePressedUsers < ActiveRecord::Migration
  def change
    create_table :pressed_users do |t|
      t.integer :comment_id
      t.integer :pressed_user_id

      t.timestamps null: false
    end
  end
end
