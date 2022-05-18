class BookingsController < ApplicationController
  before_action :set_booking, only: %i[update destroy edit]
  before_action :set_listing, only: %i[new create]
  before_action :authenticate_user!
  before_action :check_auth

  def index
    @all_bookings = []
    current_user.bookings_as_tutor.each do |booking|
      @all_bookings << booking
    end
    current_user.bookings_as_student.each do |booking|
      @all_bookings << booking
    end
    @all_bookings.sort_by!(&:start)
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(student: current_user, listing: @listing, **booking_params)
    create_validator(@booking, bookings_path)
  end

  def edit; end

  def update
    update_validator(@booking, booking_params, bookings_path)
  end

  def destroy
    @booking.destroy
    redirect_to bookings_path
  end

  private

  def check_auth
    authorize Booking
  end

  def set_listing
    @listing = Listing.find(params[:listing_id])
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start, :finish)
  end
end
