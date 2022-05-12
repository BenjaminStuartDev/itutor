class ListingsController < ApplicationController
  before_action :authenticate_user!, except: %i[index]
  
  def index
    @listings = Listing.all
  end

  def show
    @listing = Listing.find(params[:id])
  end

  def new; end

  def edit; end

  def update; end

  def destroy; end
end
