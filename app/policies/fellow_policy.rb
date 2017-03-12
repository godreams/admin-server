class FellowPolicy < ApplicationPolicy
  def index?
    user&.national_finance_head?
  end

  def show?
    index?
  end

  def create?
    index?
  end
end
