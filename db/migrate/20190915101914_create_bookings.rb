class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.references :user, index: true, foreign_key: true
      t.boolean :is_active
      t.date :repair_date
      t.datetime :start_at
      t.datetime :end_at
      t.timestamps
    end
  end
end
