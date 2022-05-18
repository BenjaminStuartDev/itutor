class WatchlistController < ApplicationController
  before_action :set_listing, only: %i[create destroy]
  before_action :authenticate_user!

  def index
    @watchlist = current_user.saved_listings
  end

  def create
    current_user.saved_listings << @listing
    redirect_to listings_path
  end

  def destroy
    current_user.saved_listings.delete(@listing)
    redirect_to listings_path
  end

  def set_listing
    @listing = Listing.find(params[:id])
  end
end
