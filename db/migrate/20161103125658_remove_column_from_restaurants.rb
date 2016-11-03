class RemoveColumnFromRestaurants < ActiveRecord::Migration
  def change
    remove_column :restaurants, :num_seats, :integer
    remove_column :restaurants, :num_people, :integer
    remove_column :restaurants, :seats_occ, :integer
    remove_column :restaurants, :crowdedness, :integer
  end
end
