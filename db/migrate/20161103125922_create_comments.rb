class CreateComments < ActiveRecord::Migration
  def change

    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :nickname
      t.string :image_url

      t.timestamps null: false
    end

    create_table :actions do |t|
      t.belongs_to :user
      t.integer :like_it
      t.integer :post_count
      t.integer :be_liked
      t.integer :point

      t.timestamps null: false
    end

    create_table :restaurants do |t|
      t.string :name
      t.string :hurigana

      t.timestamps null: false
    end

    create_table :comments do |t|
      t.belongs_to :user
      t.belongs_to :restaurant
      t.string :comment
      t.integer :crowdedness, null: false, default: 0
      t.integer :be_liked

      t.timestamps null: false
    end
  end
end
