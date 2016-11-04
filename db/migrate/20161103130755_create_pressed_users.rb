class CreatePressedUsers < ActiveRecord::Migration
  def change

    create_table :pressed_users do |t|
      t.belongs_to :comment
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end
