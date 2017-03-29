module Volunteers
  class CsvExportService
    def initialize(volunteers)
      @volunteers = volunteers
    end

    def export
      CSV.generate do |csv|
        csv << %w(id name email phone city coach_id coach_name fellow_id fellow_name nfh_id nfh_name sign_in_count last_sign_in_at created_at updated_at)

        @volunteers.includes(:user, :city, coach: { fellow: :national_finance_head }).each_with_object(csv) do |volunteer, csv|
          csv << [
            volunteer.id,
            volunteer.name,
            volunteer.email,
            volunteer.phone,
            volunteer.city&.name,
            volunteer.coach.id,
            volunteer.coach.name,
            volunteer.fellow.id,
            volunteer.fellow.name,
            volunteer.national_finance_head.id,
            volunteer.national_finance_head.name,
            volunteer.user.sign_in_count,
            volunteer.user.last_sign_in_at,
            volunteer.created_at,
            volunteer.updated_at
          ]
        end
      end
    end
  end
end
