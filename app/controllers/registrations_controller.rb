# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    super do |user|
      add_roles_to_user(user, params[:user][:roles])
    end
  end

  def update
    super do |user|
      add_roles_to_user(user, params[:user][:roles])
    end
  end

  private

  def add_roles_to_user(user, roles)
    roles.each do |role|
      user.add_role role if %w[student tutor].include?(role)
    end
  end
end
