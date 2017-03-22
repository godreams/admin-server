module Donations
  class FilterForm < Reform::Form
    property :volunteer, virtual: true

    # TODO: Shouldn't the default 'prepopulate!' work here? Not sure why it didn't when i tried.
    def prepopulate!(options)
      self.volunteer = options.dig(:volunteer)
    end
  end
end