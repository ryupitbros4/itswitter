class CreateApplies < ActiveRecord::Migration
  def change
    create_table :applies do |t|
      t.text :free
      t.string :apply_restaurant

      t.timestamps null: false
    end
  end
end
