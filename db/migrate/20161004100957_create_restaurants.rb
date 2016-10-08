# -*- coding: utf-8 -*-
class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.integer :num_seats
      t.integer :num_people
      t.integer :seats_occ
      
      t.timestamps null: false
    end
  end
end
