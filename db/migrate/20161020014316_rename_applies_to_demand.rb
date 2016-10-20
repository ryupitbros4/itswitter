class RenameAppliesToDemand < ActiveRecord::Migration
  def change
    rename_table :applies, :demands
  end
end
