class CreateAutoHistoryTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :auto_history_types do |t|
      t.references :auto_history, index: true, foreign_key: true
      t.references :type_of_repairs, index: true, foreign_key: true
      t.timestamps
    end
  end
end
