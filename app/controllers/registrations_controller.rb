# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
  before_action :define_roles

  def new
    super
  end

  def edit
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

  def define_roles
    @roles = Role.possible_roles
  end

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
