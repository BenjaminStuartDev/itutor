class BookingsController < ApplicationController
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
