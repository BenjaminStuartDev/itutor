class WatchlistController < ApplicationController
  before_action :set_listing, only: %i[create destroy]
  before_action :authenticate_user!

  # Sets a list of saved_listings and renders the watchlist index view.
  def index
    @watchlist = current_user.saved_listings
  end

  # Adds a new listing to the users watchlist and redirects to the listings_path
  def create
    current_user.saved_listings << @listing
    redirect_to listings_path
  end

  # Attempts to destroy the users watchlist and will fallback to the root_path
  def destroy
    current_user.saved_listings.delete(@listing)
    redirect_back(fallback_location: root_path)
  end

  # Sets the listing object
  def set_listing
    @listing = Listing.find(params[:id])
  end
end
