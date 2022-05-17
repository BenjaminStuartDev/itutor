class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    custom_fields = %i[name bio profile_picture roles]
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(*custom_fields, :email, :password) }

    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(*custom_fields, :email, :password, :current_password)
    end
  end
  # Devise User model custom fields setup
  # def configure_permitted_parameters
  #
  #   devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(*custom_fields, :email, :password) }
  #   devise_parameter_sanitizer.for(:account_update) do |u|
  #     u.permit(*custom_fields, :email, :password, :current_password)
  #   end
  # end
end
