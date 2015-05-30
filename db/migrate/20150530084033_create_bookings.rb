class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :user_id
      t.integer :plan_id
      t.string :charge_id
      t.string :card_fingerprint

      t.timestamps null: false
    end
  end
end
