class ChangeColumnToDemand < ActiveRecord::Migration
  def change
    rename_column :demands, :apply_restaurant, :demand_restaurant
  end
end
