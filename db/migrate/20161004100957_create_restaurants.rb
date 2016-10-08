class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.integer :num_seats
      t.integer :num_people, default: 0
      t.integer :seats_occ, default: 0

      t.timestamps null: false
    end
  end
end
