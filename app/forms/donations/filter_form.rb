module Donations
  class FilterForm < Reform::Form
    property :volunteer, virtual: true, prepopulator: ->(options) { self.volunteer = options&.dig(:volunteer) }
  end
end
