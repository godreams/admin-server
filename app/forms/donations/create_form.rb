module Donations
  class CreateForm < Reform::Form
    property :name, validates: { presence: true }
    property :email, validates: { presence: true, email: true }
    property :phone, validates: { presence: true, mobile_number: true }
    property :amount, validates: { presence: true }
    property :pan, validates: { presence: true }
    property :address, validates: { presence: true }

    def save!(volunteer)
      sync
      model.volunteer = volunteer
      model.save!
      Donations::AcknowledgementJob.perform_later(model.reload)
    end
  end
end
