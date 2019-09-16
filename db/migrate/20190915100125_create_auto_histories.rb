class CreateAutoHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :auto_histories do |t|
      t.references :user, index: true, foreign_key: true
      t.references :vehicle, index: true, foreign_key: true
      t.text :desc
      t.timestamps
    end
  end
end
