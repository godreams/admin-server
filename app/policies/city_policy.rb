class CityPolicy < ApplicationPolicy
  def index?
    user&.national_finance_head?
  end

  alias new? index?
  alias create? index?
end