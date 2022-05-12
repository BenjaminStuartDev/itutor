class BookingsController < ApplicationController
  def index
    @bookings_tutor = current_user.bookings_as_tutor
    @bookings_student = current_user.bookings_as_student
  end

  def new
    @booking = Booking.new
  end

  def create
    booking_params = params.require(:booking).permit(:tutor, :listing, :start, :finish)
    booking = Booking.create(student: current_user, **booking_params)
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def update
    @booking = Booking.find(params[:id])
    booking_params = params.require(:booking).permit(:tutor, :listing, :start, :finish)
    @booking.update(booking_params)
    redirect_to bookings_path
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to bookings_path
  end
end
