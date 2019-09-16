class CreateTypeOfRepairs < ActiveRecord::Migration[5.2]
  def change
    create_table :type_of_repairs do |t|
      t.string :code
      t.text :desc
      t.integer :repair_time
      t.integer :price
      t.timestamps
    end
  end
end
