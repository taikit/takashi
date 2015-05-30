json.array!(@bookings) do |booking|
  json.extract! booking, :id, :user_id, :plan_id, :charge_id, :card_fingerprint
  json.url booking_url(booking, format: :json)
end
