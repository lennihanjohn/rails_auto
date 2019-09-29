class ChangeDayOfBusinessHour < ActiveRecord::Migration[5.2]
  def change
    change_column :day_of_business_hours, :open_at, :time
    change_column :day_of_business_hours, :close_at, :time
  end
end
