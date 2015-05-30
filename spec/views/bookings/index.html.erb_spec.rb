require 'rails_helper'

RSpec.describe "bookings/index", type: :view do
  before(:each) do
    assign(:bookings, [
      Booking.create!(
        :user_id => 1,
        :plan_id => 2,
        :charge_id => "Charge",
        :card_fingerprint => "Card Fingerprint"
      ),
      Booking.create!(
        :user_id => 1,
        :plan_id => 2,
        :charge_id => "Charge",
        :card_fingerprint => "Card Fingerprint"
      )
    ])
  end

  it "renders a list of bookings" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Charge".to_s, :count => 2
    assert_select "tr>td", :text => "Card Fingerprint".to_s, :count => 2
  end
end
