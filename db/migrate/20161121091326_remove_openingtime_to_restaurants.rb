class RemoveOpeningtimeToRestaurants < ActiveRecord::Migration
  def change
    remove_column :restaurants, :start_hour, :string
    remove_column :restaurants, :start_minute, :string
    remove_column :restaurants, :end_hour, :string
    remove_column :restaurants, :end_minute, :string
  end
end
