class Approval < ApplicationRecord
  belongs_to :donation
  belongs_to :approver, polymorphic: true

  validates :donation, uniqueness: { scope: [:approver] }
end
