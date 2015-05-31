class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  #before_action :check_booked, only: [:new, :create]

  # GET /bookings/new
  def new
    @day = Day.find(params[:day_id])
    @plan = @day.plan
    @booking = @plan.build_booking
    check_booked(@day)
  end

  # POST /bookings
  # POST /bookings.json
  def create
    @booking = Booking.new(booking_params)
    @booking.day = Day.find(params[:day_id])
    @booking.plan = Plan.find(params[:plan_id])
    check_booked(@day)
    @booking.user = current_user
    respond_to do |format|
      if @booking.save_with_pay(params['webpay-token'])
        format.html { redirect_to root_path, notice: 'Booking was successfully created.' }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :new }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_booking
    @booking = Booking.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def booking_params
    params.require(:booking).permit(:user_id, :plan_id, :charge_id, :card_fingerprint, :day_id)
  end

  def check_booked(day)
    if day.booking
      redirect_to day.plan, alert: 'This plan was already booked.'
    end
  end
end
