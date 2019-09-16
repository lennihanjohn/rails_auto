class CreateDayOfWeeks < ActiveRecord::Migration[5.2]
  def change
    create_table :day_of_weeks do |t|
      t.string :day_of_week
      t.timestamps
    end
  end
end
