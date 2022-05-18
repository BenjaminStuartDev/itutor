# frozen_string_literal: true

class ListingPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    @user&.has_role?(:tutor)
  end

  def new?
    create?
  end

  def update?
    @user&.has_role?(:tutor)
  end

  def edit?
    update?
  end

  def destroy?
    @user&.has_any_role?(:tutor)
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NotImplementedError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end
end
