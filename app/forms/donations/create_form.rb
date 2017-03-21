module Donations
  class CreateForm < Reform::Form
    property :name, validates: { presence: true }
    property :email, validates: { presence: true, email: true }
    property :phone, validates: { presence: true, mobile_number: true }
    property :amount, validates: { presence: true }
    property :tax_claim
    property :pan
    property :address

    validate :pan_required_if_tax_claimed

    def pan_required_if_tax_claimed
      return if tax_claim == '0'
      errors[:pan] << 'is required for tax claim' if pan.blank?
      errors[:address] << 'is required for tax claim' if pan.blank?
    end

    def save!(volunteer)
      sync
      model.volunteer = volunteer
      model.save!
      Donations::AcknowledgementJob.perform_later(model.reload)
    end
  end
end
