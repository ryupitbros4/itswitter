class ChangeDatatypeHolidayOfRestaurants < ActiveRecord::Migration
  def change
    change_column :restaurants, :holiday, :string
  end
end
