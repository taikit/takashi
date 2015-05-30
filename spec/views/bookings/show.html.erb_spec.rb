require 'rails_helper'

RSpec.describe "bookings/show", type: :view do
  before(:each) do
    @booking = assign(:booking, Booking.create!(
      :user_id => 1,
      :plan_id => 2,
      :charge_id => "Charge",
      :card_fingerprint => "Card Fingerprint"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Charge/)
    expect(rendered).to match(/Card Fingerprint/)
  end
end
