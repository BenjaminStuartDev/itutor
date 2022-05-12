class ReviewsController < ApplicationController
  def index
    @made_reviews = current_user.made_reviews
  end

  def tutor_reviews
    @user = User.find(params[:user_id])
    @made_reviews = @user.reviews
  end

  def new
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
