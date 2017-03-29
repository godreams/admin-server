module Donations
  class FilterForm < Reform::Form
    property :volunteer, virtual: true, prepopulator: ->(options) { self.volunteer = options&.dig(:volunteer) }
    property :city, virtual: true, prepopulator: ->(options) { self.city = options&.dig(:city) }
  end
end
