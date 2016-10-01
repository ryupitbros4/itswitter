class CreateJams < ActiveRecord::Migration
  def change
    create_table :jams do |t|
      t.text :store
      t.integer :congestion

      t.timestamps null: false
    end
  end
end
