class NationalFinanceHeadPolicy < ApplicationPolicy
  def index?
    user.national_finance_head?
  end

  def show?
    index?
  end
end
