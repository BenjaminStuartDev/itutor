class ListingsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  
  def index
    @listings = Listing.all
  end

  def show
    @listing = Listing.find(params[:id])
  end

  def new
    @listing = Listing.new
  end

  def create
    listing_params = params.require(:listing).permit(:title, :content)
    listing = Listing.create(tutor: current_user, **listing_params)
    redirect_to listing
  end

  def edit
    @listing = Listing.find(params[:id])
  end

  def update
    @listing = Listing.find(params[:id])
    listing_new_params = params.require(:listing).permit(:title, :content)
    @listing.update(listing_new_params)
    redirect_to listing
  end

  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy
    redirect_to listings_path
  end
end
