module Donations
  class FilterService
    def initialize(donations)
      @donations = donations
    end

    def filter(filter_params)
      @filter_params = filter_params

      %i(city fellow coach volunteer).each do |field|
        filter_for(field) if @filter_params&.dig(field).present?
      end

      @donations
    end

    private

    def filter_for(field)
      clazz = field.to_s.capitalize.constantize
      @donations = @donations.merge(clazz.find(@filter_params[field]).donations)
    end
  end
end