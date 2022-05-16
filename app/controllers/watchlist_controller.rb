class WatchlistController < ApplicationController
  def index
    @watchlist = current_user.saved_listings
  end

  def create
    listing = Listing.find(params[:id])
    current_user.saved_listings << listing
    redirect_back(fallback_location: listings_path)
  end

  def destroy
    listing = Listing.find(params[:id])
    current_user.saved_listings.delete(listing)
    redirect_back(fallback_location: listings_path)
  end
end
