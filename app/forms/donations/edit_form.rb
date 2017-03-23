module Donations
  class EditForm < CreateForm
    def save
      sync
      model.save!
    end
  end
end
