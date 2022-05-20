class ApplicationController < ActionController::Base
  include Pundit
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :forbidden

  protected

  # Redirects to root_path and flashes unauthorised action alert.
  def forbidden
    flash[:alert] = 'You are not authorized to perform that action. You can change your roles in Account.'
    redirect_to root_path
  end

  # Configures the permitted parameters fro the devise registrations controller
  def configure_permitted_parameters
    custom_fields = %i[name bio profile_picture]
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(*custom_fields, :email, :password) }

    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(*custom_fields, :email, :password, :current_password)
    end
  end

  # redirects to redirect_path if the object passes validation or renders the edit view with the error flash during unsuccesful validation.
  #
  # @param object [Object] An object containing the record to be updated.
  # @param object_params [Array] an array containing the parameters to be updated.
  # @param redirect_path [String] a string containing the path/route to redirect to
  def update_validator(object, object_params, redirect_path)
    object.update!(object_params)
    redirect_to redirect_path
  rescue StandardError
    flash.now[:alert] = object.errors.full_messages.join('<br>')
    render 'edit'
  end

  # redirects to redirect_path if the object passes validation or renders the new view with the error flash during unsuccesful validation.
  # If succesful validation it will save the object in the database.
  #
  # @param object [Object] An object containing the record to be updated.
  # @param redirect_path [String] a string containing the path/route to redirect to
  def create_validator(object, redirect_path)
    if object.valid?
      object.save
      redirect_to redirect_path
    else
      flash.now[:alert] = object.errors.full_messages.join('<br>')
      render 'new'
    end
  end
end
