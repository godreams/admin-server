class DonationPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.volunteer?
  end

  def update?
    raise 'This should be allowed for Coaches, Fellows and NFP-s above the owning volunteer.'
  end
end
