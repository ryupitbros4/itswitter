class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.string :uid
      t.integer :like_it
      t.integer :post_count
      t.integer :be_liked
      t.integer :point
      
      t.timestamps null: false
    end
  end
end
