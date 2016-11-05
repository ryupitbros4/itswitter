class CreatePressedUsers < ActiveRecord::Migration
  def change

    create_table :pressed_users do |t|
      t.belongs_to :comment, null: false
      t.belongs_to :user, null: false

      t.timestamps null: false
    end
  end
end
