class AddArchiveToDemands < ActiveRecord::Migration
  def change
    add_column :demands, :archive, :boolean, null: false, default: false
  end
end
