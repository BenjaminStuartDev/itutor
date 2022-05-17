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
    subject = params[:listing][:subjects]
    @listing = Listing.new(tutor: current_user, **listing_params)
    @listing.subjects << Subject.find_by(name: subject)

    if @listing.valid?
      @listing.save
      redirect_to @listing
    else
      flash.now[:alert] = @listing.errors.full_messages.join('<br>')
      render 'new'
    end
  end

  def edit
    @listing = Listing.find(params[:id])
  end

  def update
    @listing = Listing.find(params[:id])
    listing_params = params.require(:listing).permit(:title, :content)
    @listing.update(listing_params)
    @listing.subjects.destroy_all
    subject = params[:listing][:subjects]
    @listing.subjects << Subject.find_by(name: subject)
    redirect_to @listing
  end

  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy
    redirect_to listings_path
  end
end
