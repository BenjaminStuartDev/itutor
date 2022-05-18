class ReviewsController < ApplicationController
  before_action :set_review, only: %i[edit update destroy]
  before_action :review_params, only: %i[create update]
  before_action :authenticate_user!
  before_action :check_auth

  def index
    @reviews = current_user.made_reviews
  end

  def new
    @review = Review.new
    @user = User.find(params[:user_id])
  end

  def create
    @review = Review.new(student: current_user, tutor_id: params[:user_id], **review_params)
    create_validator(@review, @review.tutor)
  end

  def edit; end

  def update
    update_validator(@review, review_params, @review.tutor)
  end

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
