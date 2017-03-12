class VolunteerPolicy < ApplicationPolicy
  def index?
    user&.coach? || user&.fellow? || user&.national_finance_head?
  end

  def show?
    index?
  end

  def create?
    user&.coach?
  end
end
