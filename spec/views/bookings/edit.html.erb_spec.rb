require 'rails_helper'

RSpec.describe "bookings/edit", type: :view do
  before(:each) do
    @booking = assign(:booking, Booking.create!(
      :user_id => 1,
      :plan_id => 1,
      :charge_id => "MyString",
      :card_fingerprint => "MyString"
    ))
  end

  it "renders the edit booking form" do
    render

    assert_select "form[action=?][method=?]", booking_path(@booking), "post" do

      assert_select "input#booking_user_id[name=?]", "booking[user_id]"

      assert_select "input#booking_plan_id[name=?]", "booking[plan_id]"

      assert_select "input#booking_charge_id[name=?]", "booking[charge_id]"

      assert_select "input#booking_card_fingerprint[name=?]", "booking[card_fingerprint]"
    end
  end
end
