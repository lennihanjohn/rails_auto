class AddDescToBooking < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :desc, :text

  end
end
