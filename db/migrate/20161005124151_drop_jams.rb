class DropJams < ActiveRecord::Migration
  def change
    drop_table :jams
  end
end
