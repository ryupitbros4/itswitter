class ChangeColumnToFeedback < ActiveRecord::Migration
  def change
    change_column :feedbacks, :archive, :boolean, null: false, default: false
  end
end
