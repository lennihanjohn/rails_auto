class ChangeRepairTimeTypeToFloat < ActiveRecord::Migration[5.2]
  def change
    change_column :type_of_repairs, :repair_time, :float
  end
end
