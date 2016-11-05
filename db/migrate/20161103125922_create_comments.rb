class CreateComments < ActiveRecord::Migration
  def change

    create_table :users do |t|
      t.string :provider, null: false
      t.string :uid, null: false
      t.string :nickname, null: false
      t.string :image_url, null: false

      t.timestamps null: false
    end

    add_index :users, :uid, unique: true

    create_table :restaurants do |t|
      t.string :name, null: false
      t.string :hurigana, null: false

      t.timestamps null: false
    end

    create_table :comments do |t|
      t.belongs_to :user, null: false
      t.belongs_to :restaurant, null: false
      t.string :comment
      t.integer :crowdedness, null: false, limit: 2

      t.timestamps null: false
    end
  end
end
