# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
  before_action :define_roles
  # Calls the devise registrations new action
  def new
    super
  end

  # Calls the devise registrations edit action
  def edit
    super
  end

  # Calls the devise registrations create action and changes the roles on the user.
  def create
    super do |user|
      change_roles_on_user(user, params[:user][:roles])
    end
  end

  # Calls the devise registrations update action and changes the roles on the user.
  def update
    super do |user|
      change_roles_on_user(user, params[:user][:roles])
    end
  end

  private

  # Sets @roles as a list of possible roles
  def define_roles
    @roles = Role.possible_roles
  end

  # Sets the roles of the user resource
  #
  # @param user [User] The user object to be updates
  # @param roles [Array] an array containing strings for the new roles
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
