class UserPolicy < ApplicationPolicy
  ROLE_VALUE = {
    Volunteer => 0,
    Coach => 1,
    Fellow => 2,
    NationalFinanceHead => 3
  }

  # NationalFinanceHead can update anyone. Others can update all below them in rank.
  def update?
    UserPolicy::ROLE_VALUE[user.dominant_role.class] == 3 ||
      UserPolicy::ROLE_VALUE[user.dominant_role.class] > UserPolicy::ROLE_VALUE[record.dominant_role.class]
  end

  def show?
    update?
  end
end
