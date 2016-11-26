class CreateOpeningHours < ActiveRecord::Migration
  def change
    create_table :opening_hours do |t|
      t.belongs_to :restaurant, null: false
      t.integer :start_hour
      t.integer :start_minute
      t.integer :end_hour
      t.integer :end_minute

      t.timestamps null: false
    end
  end
end
