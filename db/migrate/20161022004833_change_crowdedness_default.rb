class ChangeCrowdednessDefault < ActiveRecord::Migration
  def change
    change_column :restaurants, :crowdedness, :integer, null: false, default: 0
  end
end
