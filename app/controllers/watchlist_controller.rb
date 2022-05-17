class WatchlistController < ApplicationController
  before_action :set_listing, only: %i[create destroy]
  def index
    @watchlist = current_user.saved_listings
  end

  def create
    current_user.saved_listings << @listing
    redirect_back(fallback_location: listings_path)
  end

  def destroy
    current_user.saved_listings.delete(@listing)
    redirect_back(fallback_location: listings_path)
  end

  def set_listing
    @listing = Listing.find(params[:id])
  end
end
