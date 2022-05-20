class ListingsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :check_auth
  before_action :set_listing, only: %i[show update destroy edit]
  before_action :set_listing_subjects, only: %i[update create]

  # Sets a list of listings renders the listing index view.
  def index
    @listings = Listing.all
  end

  # Renders the show listing view
  def show; end

  # Creates and sets a new instance of listing.
  def new
    @listing = Listing.new
  end

  # Validates the params fields and saves a new listing if it passes validation
  # else renders the new form with relevent error alert.
  def create
    create_validator(@listing, @listing)
  end

  # Renders the edit Listing form
  def edit; end

  # Attempts to update the Listing and if it passes validation it will render the @listing,
  # else, it will redirect to root_path with relevent error alert
  def update
    if (current_user != @listing.tutor) || (current_user.present? == false)
      flash[:notice] = 'Access Denied'
      return redirect_to(:root)
    end

    update_validator(@listing, listing_params, @listing)
  end

  # Attempts to destroy the record if the user is tied to the listing and
  # present otherwise it will redirect to the root path with the relevent error alert.
  def destroy
    if (current_user != @listing.tutor) || (current_user.present? == false)
      flash[:notice] = 'Access Denied'
      return redirect_to(:root)
    end

    @listing.destroy
    redirect_to listings_path
  end

  private

  # Sets the authorisation policies to be used as a before action
  def check_auth
    authorize Listing
  end

  # Sets the listing subjects for the listing resource
  def set_listing_subjects
    @listing = Listing.new(tutor: current_user, **listing_params)
    subject = params[:listing][:subjects]
    @listing.subjects << Subject.find_by(name: subject)
  end

  # returns the listing strong parameters defined in the route request
  def listing_params
    params.require(:listing).permit(:title, :content)
  end

  # Sets the listing resource based on the listing id
  def set_listing
    @listing = Listing.find(params[:id])
  end
end
