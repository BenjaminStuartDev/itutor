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

  def update_validator(object, object_params, redirect_path)
    object.update!(object_params)
    redirect_to redirect_path
  rescue StandardError
    flash.now[:alert] = object.errors.full_messages.join('<br>')
    render 'edit'
  end

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
