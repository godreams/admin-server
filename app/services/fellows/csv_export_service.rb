module Fellows
  class CsvExportService
    def initialize(fellows)
      @fellows = fellows
    end

    def export
      CSV.generate do |csv|
        csv << %w(id name email phone city coaches_count volunteers_count nfh_id nfh_name sign_in_count last_sign_in_at created_at updated_at)

        @fellows.includes(:user, :national_finance_head).each_with_object(csv) do |fellow, csv|
          csv << [
            fellow.id,
            fellow.name,
            fellow.email,
            fellow.phone,
            fellow.city&.name,
            fellow.coaches.count,
            fellow.volunteers.count,
            fellow.national_finance_head.id,
            fellow.national_finance_head.name,
            fellow.user.sign_in_count,
            fellow.user.last_sign_in_at,
            fellow.created_at,
            fellow.updated_at
          ]
        end
      end
    end
  end
end
