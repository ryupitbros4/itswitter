class AddPointsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :point, :integer, null: false, default: 0
  end
end
