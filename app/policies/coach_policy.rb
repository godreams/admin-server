class CoachPolicy < ApplicationPolicy
  def index?
    user.fellow? || user.national_finance_head?
  end

  def show?
    index?
  end

  def create?
    user.fellow?
  end
end
