class ReviewsController < ApplicationController
  before_action :set_review, only: %i[edit update destroy]
  before_action :review_params, only: %i[create update]
  before_action :authenticate_user!
  before_action :check_auth

   # Sets a list of made_reviews and renders the review index view.
  def index
    @reviews = current_user.made_reviews.order(created_at: :desc)
  end 
  # Creates and sets a new instance of review.
  def new
    @review = Review.new
    @user = User.find(params[:user_id])
  end

  def create
    @review = Review.new(student: current_user, tutor_id: params[:user_id], **review_params)
    create_validator(@review, @review.tutor)
  end
  # Renders the edit Review form
  def edit
    if (current_user != @review.student) || (current_user.present? == false)
      flash[:notice] = 'Access Denied'
      return redirect_to(:root)
    end
  end
  # Attempts to update the review and if it passes validation it will render the @review.tutor
  # else, it will redirect to root_path with relevent error alert
  def update
    if (current_user != @review.student) || (current_user.present? == false)
      flash[:notice] = 'Access Denied'
      return redirect_to(:root)
    end
    update_validator(@review, review_params, @review.tutor)
  end

  # Destroys the review record
  def destroy
    @review.destroy
    redirect_to reviews_path
  end

  private
  def check_auth
    authorize Review
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end

  def set_review
    @review = Review.find(params[:id])
  end
end
