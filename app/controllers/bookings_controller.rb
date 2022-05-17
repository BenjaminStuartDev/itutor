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
    @listing = Listing.find(params[:listing_id])
    booking_params = params.require(:booking).permit(:start, :finish)
    @booking = Booking.new(student: current_user, listing: @listing, **booking_params)

    if @booking.valid?
      redirect_to bookings_path
      @booking.save
    else
      flash.now[:alert] = @booking.errors.full_messages.join('<br>')
      render 'new'
    end
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def update
    @booking = Booking.find(params[:id])
    booking_params = params.require(:booking).permit(:start, :finish)
    begin
      @booking.update!(booking_params)
      redirect_to bookings_path
    rescue
      flash.now[:alert] = @booking.errors.full_messages.join('<br>')
      render 'edit'
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to bookings_path
  end
end
