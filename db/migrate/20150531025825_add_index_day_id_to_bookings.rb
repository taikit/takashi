class AddIndexDayIdToBookings < ActiveRecord::Migration
  def change
    add_index :bookings, :day_id, :unique => true
  end
end
