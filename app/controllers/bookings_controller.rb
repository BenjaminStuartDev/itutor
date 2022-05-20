class BookingsController < ApplicationController
  before_action :set_booking, only: %i[update destroy edit]
  before_action :set_listing, only: %i[new create]
  before_action :authenticate_user!
  before_action :check_auth

  # Sets a list of bookings that occur in the future sorted by the start date and renders the Bookings index view.
  def index
    @all_bookings = []
    current_user.bookings_as_tutor.in_future.each do |booking|
      @all_bookings << booking
    end
    current_user.bookings_as_student.in_future.each do |booking|
      @all_bookings << booking
    end
    @all_bookings.sort_by!(&:start)
  end

  # Creates and sets a new instance of Booking.
  def new
    @booking = Booking.new
  end

  # Validates the params fields and saves a new booking and render the bookings_path if it
  # passes validation else renders the new form with relevent error alert.
  def create
    @booking = Booking.new(student: current_user, listing: @listing, **booking_params)
    create_validator(@booking, bookings_path)
  end

  # Renders the edit booking form
  def edit; end

  # Attempts to update the Booking and if it passes validation it will render the bookings_path,
  # else, it will redirect to root_path with relevent error alert
  def update
    if ((current_user != @booking.tutor) && (current_user != @booking.student)) || (current_user.present? == false)
      flash[:notice] = 'Access Denied'
      return redirect_to(:root)
    end
    update_validator(@booking, booking_params, bookings_path)
  end

  # Attempts to destroy the record if the user is tied to the booking and
  # present otherwise it will redirect to the root path with the relevent error alert.
  def destroy
    if ((current_user != @booking.tutor) && (current_user != @booking.student)) || (current_user.present? == false)
      flash[:notice] = 'Access Denied'
      return redirect_to(:root)
    end
    @booking.destroy
    redirect_to bookings_path
  end

  private

  # Sets the authorisation policies to be used as a before action
  def check_auth
    authorize Booking
  end

  # Sets the listing resource based on the listing id
  def set_listing
    @listing = Listing.find(params[:listing_id])
  end

  # Sets the booking resource based on the booking id
  def set_booking
    @booking = Booking.find(params[:id])
  end

  # Returns the strong params for booking based on the route.
  def booking_params
    params.require(:booking).permit(:start, :finish)
  end
end
