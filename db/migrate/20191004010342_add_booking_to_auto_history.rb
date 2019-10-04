class AddBookingToAutoHistory < ActiveRecord::Migration[5.2]
  def change
    add_reference :auto_histories, :booking, foreign_key: true, index: true
  end
end
