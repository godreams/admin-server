module Coaches
  class CsvExportService
    def initialize(coaches)
      @coaches = coaches
    end

    def export
      CSV.generate do |csv|
        csv << %w(id name email phone city volunteers_count fellow_id fellow_name nfh_id nfh_name sign_in_count last_sign_in_at created_at updated_at)

        @coaches.includes(:user, fellow: :national_finance_head).each_with_object(csv) do |coach, csv|
          csv << [
            coach.id,
            coach.name,
            coach.email,
            coach.phone,
            coach.city&.name,
            coach.volunteers.count,
            coach.fellow.id,
            coach.fellow.name,
            coach.national_finance_head.id,
            coach.national_finance_head.name,
            coach.user.sign_in_count,
            coach.user.last_sign_in_at,
            coach.created_at,
            coach.updated_at
          ]
        end
      end
    end
  end
end
