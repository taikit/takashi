class AddDayIdToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :day_id, :integer
  end
end
