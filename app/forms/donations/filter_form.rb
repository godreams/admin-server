module Donations
  class FilterForm < Reform::Form
    property :volunteer, virtual: true, prepopulator: ->(options) { self.volunteer = options&.dig(:volunteer) }
    property :city, virtual: true, prepopulator: ->(options) { self.city = options&.dig(:city) }
    property :coach, virtual: true, prepopulator: ->(options) { self.coach = options&.dig(:coach) }
    property :fellow, virtual: true, prepopulator: ->(options) { self.fellow = options&.dig(:fellow) }
  end
end
