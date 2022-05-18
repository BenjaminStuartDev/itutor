# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    super do |user|
      change_roles_on_user(user, params[:user][:roles])
    end
  end

  def update
    super do |user|
      change_roles_on_user(user, params[:user][:roles])
    end
  end

  private

  def change_roles_on_user(user, roles)
    if roles.present?
      old_roles = user.roles
      old_roles.each do |role|
        user.remove_role(role.name)
      end
      roles.each do |role|
        user.add_role role if %w[student tutor].include?(role)
      end
    end
  end
end
