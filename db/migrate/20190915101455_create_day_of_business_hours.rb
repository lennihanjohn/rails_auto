class CreateDayOfBusinessHours < ActiveRecord::Migration[5.2]
  def change
    create_table :day_of_business_hours do |t|  
      t.references :day_of_week, index: true, foreign_key: true
      t.datetime :open_at
      t.datetime :close_at
      t.boolean :is_overlap
      t.timestamps
    end
  end
end
