class VolunteerPolicy < ApplicationPolicy
  def index?
    user.coach?
  end

  def show?
    user.coach?
  end

  def create?
    user.coach?
  end
end
