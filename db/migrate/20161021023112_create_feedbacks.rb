class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :name
      t.text :opinion
      t.boolean :archive, default: false

      t.timestamps null: false
    end
  end
end
