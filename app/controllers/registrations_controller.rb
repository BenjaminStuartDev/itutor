# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
  def new
    @roles = Role.possible_roles
    super
  end

  def edit
    @roles = Role.possible_roles
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
    roles.reject!(&:empty?)
    old_roles = user.roles
    old_roles.each do |role|
      user.remove_role(role.name)
    end
    return unless roles.present?

    roles.each do |role|
      user.add_role role if Role.possible_roles.map.include?(role.to_sym)
    end
  end
end
