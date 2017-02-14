class AddGidToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :gid, :string
  end
end
