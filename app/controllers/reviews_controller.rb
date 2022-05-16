class ReviewsController < ApplicationController
  def index
    @reviews = current_user.made_reviews
  end

  def new
    @review = Review.new
  end

  def create
    review_params = params.require(:review).permit(:content, :rating)
    Review.create(student: current_user, tutor_id: params[:user_id], **review_params)
    redirect_back(fallback_location: listings_path)
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    review_params = params.require(:review).permit(:content, :rating)
    @review.update(review_params)
    redirect_to @review.tutor
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to reviews_path
  end
end
