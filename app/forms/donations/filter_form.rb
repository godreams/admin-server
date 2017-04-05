module Donations
  class FilterForm < Reform::Form
    property :volunteer, virtual: true
    property :city, virtual: true
    property :coach, virtual: true
    property :fellow, virtual: true

    def prepopulate(options)
      return if options.blank?

      self.volunteer = options[:volunteer]
      self.city = options[:city]
      self.coach = options[:coach]
      self.fellow = options[:fellow]
    end
  end
end
