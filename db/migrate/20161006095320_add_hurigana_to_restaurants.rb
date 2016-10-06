class AddHuriganaToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :hurigana, :string
  end
end
