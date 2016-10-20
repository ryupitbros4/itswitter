class AddCrowdednessToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :crowdedness, :integer
  end
end
