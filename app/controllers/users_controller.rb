class UsersController < ApplicationController
  # Renders the show User view based on the user id
  def show
    @user = User.find(params[:id])
  end
end
