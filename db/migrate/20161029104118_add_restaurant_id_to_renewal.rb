class AddRestaurantIdToRenewal < ActiveRecord::Migration
  def change
    add_column :renewals, :restaurant_id, :integer, null: true, default: :null
  end
end
