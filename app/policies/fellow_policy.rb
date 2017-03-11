class FellowPolicy < ApplicationPolicy
  def index?
    user.national_finance_head?
  end

  def show?
    index?
  end

  def create?
    user.national_finance_head?
  end
end
