class ChangeCodeToNameInTypeOfRepair < ActiveRecord::Migration[5.2]
  def change
    rename_column :type_of_repairs, :code, :name
  end
end
