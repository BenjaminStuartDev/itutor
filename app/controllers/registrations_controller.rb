# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    super do |user|
      roles = params[:user][:roles]
      roles.each do |role|
        user.add_role role if %w[student tutor].include?(role)
      end
    end
  end

  def update
    super do |user|
      roles = params[:user][:roles]
      roles.each do |role|
        user.add_role role if %w[student tutor].include?(role)
      end
    end
  end
end
