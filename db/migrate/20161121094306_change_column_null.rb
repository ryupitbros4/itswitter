class ChangeColumnNull < ActiveRecord::Migration
  def change
    change_column_null :opening_hours, :start_hour, false
    change_column_null :opening_hours, :start_minute, false
    change_column_null :opening_hours, :end_hour, false
    change_column_null :opening_hours, :end_minute, false
  end
end
