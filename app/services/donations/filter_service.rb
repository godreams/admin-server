module Donations
  class FilterService
    def initialize(donations)
      @donations = donations
    end

    def filter(filter_params)
      if filter_params&.dig(:volunteer).present?
        @donations = @donations.where(volunteer: Volunteer.find(filter_params[:volunteer]))
      end

      if filter_params&.dig(:city).present?
        @donations = @donations.merge(City.find(filter_params[:city]).donations)
      end

      @donations
    end
  end
end