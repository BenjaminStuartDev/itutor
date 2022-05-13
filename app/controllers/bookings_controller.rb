class BookingsController < ApplicationController
  def index
    @bookings_tutor = current_user.bookings_as_tutor
    @bookings_student = current_user.bookings_as_student
  end

  def new
    @listing = Listing.find(params[:listing_id])
    @booking = Booking.new
  end

  def create
    listing = Listing.find(params[:listing_id])
    booking_params = params.require(:booking).permit(:start, :finish)
    Booking.create(student: current_user, listing: listing, **booking_params)
    redirect_to bookings_path
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def update
    @booking = Booking.find(params[:id])
    booking_params = params.require(:booking).permit(:start, :finish)
    @booking.update(booking_params)
    redirect_to bookings_path
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to bookings_path
  end
end
