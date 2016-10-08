class Chengedefault < ActiveRecord::Migration
  def change
    change_column :restaurants, :num_people, :integer, null: false, default: 0
    change_column :restaurants, :seats_occ, :integer, null: false, default: 0
  end
end
