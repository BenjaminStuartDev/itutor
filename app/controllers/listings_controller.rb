class ListingsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :check_auth
  before_action :set_listing, only: %i[show update destroy edit]
  before_action :set_listing_subjects, only: %i[update create]

  def index
    @listings = Listing.all
  end

  def show; end

  def new
    @listing = Listing.new
  end

  def create
    create_validator(@listing, @listing)
  end

  def edit; end

  def update
    if (current_user != @listing.tutor) || (current_user.present? == false)
      flash[:notice] = 'Access Denied'
      return redirect_to(:root)
    end

    update_validator(@listing, listing_params, @listing)
  end

  def destroy
    if (current_user != @listing.tutor) || (current_user.present? == false)
      flash[:notice] = 'Access Denied'
      return redirect_to(:root)
    end

    @listing.destroy
    redirect_to listings_path
  end

  private

  def check_auth
    authorize Listing
  end

  def set_listing_subjects
    @listing = Listing.new(tutor: current_user, **listing_params)
    subject = params[:listing][:subjects]
    @listing.subjects << Subject.find_by(name: subject)
  end

  def listing_params
    params.require(:listing).permit(:title, :content)
  end

  def set_listing
    @listing = Listing.find(params[:id])
  end
end
