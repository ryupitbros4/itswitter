class AddOpeningtimeToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :start_hour, :integer
    add_column :restaurants, :start_minute, :integer
    add_column :restaurants, :end_hour, :integer
    add_column :restaurants, :end_minute, :integer
    add_column :restaurants, :holiday, :integer
  end
end
