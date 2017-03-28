module Donations
  class CsvExportService
    def initialize(donations)
      @donations = donations
    end

    def export
      CSV.generate do |csv|
        csv << %w(id name email phone amount pan address tax_claim volunteer_id volunteer_name created_at updated_at last_edited_by)

        @donations.includes(:volunteer, :versions).each_with_object(csv) do |donation, csv|
          editor = if donation.versions.any?
            version = donation.versions.last
            User.find_by(id: version.whodunnit)
          end

          csv << [
            donation.id,
            donation.name,
            donation.email,
            donation.phone,
            donation.amount,
            donation.pan,
            donation.address,
            donation.tax_claim,
            donation.volunteer_id,
            donation.volunteer.name,
            donation.created_at,
            donation.updated_at,
            editor&.name
          ]
        end
      end
    end
  end
end
