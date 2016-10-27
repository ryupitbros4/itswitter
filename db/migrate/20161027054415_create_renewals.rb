class CreateRenewals < ActiveRecord::Migration
  def change
    create_table :renewals do |t|
      t.string :update_info

      t.timestamps null: false
    end
  end
end
