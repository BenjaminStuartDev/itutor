class ReviewsController < ApplicationController
  def index
    @reviews = current_user.made_reviews
  end

  def new
    @review = Review.new
    @user = User.find(params[:user_id])
  end

  def create
    review_params = params.require(:review).permit(:content, :rating)
    @review = Review.new(student: current_user, tutor_id: params[:user_id], **review_params)

    if @review.valid?
      @review.save
      redirect_to @review.tutor
    else
      flash.now[:alert] = @review.errors.full_messages.join('<br>')
      render 'new'
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    review_params = params.require(:review).permit(:content, :rating)
    begin
      @review.update!(review_params)
      redirect_to @review.tutor
    rescue StandardError
      flash.now[:alert] = @review.errors.full_messages.join('<br>')
      render 'edit'
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to reviews_path
  end
end
