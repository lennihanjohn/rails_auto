class CreateVehicles < ActiveRecord::Migration[5.2]
  def change
    create_table :vehicles do |t|
      t.references :user, index:true, foreign_key: true
      t.string :make
      t.string :model
      t.string :color
      t.date :year
      t.timestamps
    end
  end
end
