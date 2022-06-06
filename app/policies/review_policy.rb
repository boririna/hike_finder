class ReviewPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def new?
    true
  end

  def create?
    true
  end

  def edit?
    record.user == user or user.admin?
  end

  def update?
    record.user == user or user.admin?
  end

  def destroy?
    record.user == user or user.admin?
  end

  # NOTE: Be explicit about which records you allow access to!
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end
end
