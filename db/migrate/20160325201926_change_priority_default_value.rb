class ChangePriorityDefaultValue < ActiveRecord::Migration
  def change
    change_column_default :tasks, :priority, 0
  end
end
