class RemoveForeignKeyFavoriteRestaurants < ActiveRecord::Migration
  def change
    remove_foreign_key :favorite_restaurants, :restaurants
    remove_foreign_key :favorite_restaurants, :users
  end
end
