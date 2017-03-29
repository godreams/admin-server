module NationalFinanceHeads
  class CsvExportService
    def initialize(national_finance_heads)
      @national_finance_heads = national_finance_heads
    end

    def export
      CSV.generate do |csv|
        csv << %w(id name email phone fellows_count coaches_count volunteers_count sign_in_count last_sign_in_at created_at updated_at)

        @national_finance_heads.each_with_object(csv) do |national_finance_head, csv|
          csv << [
            national_finance_head.id,
            national_finance_head.name,
            national_finance_head.email,
            national_finance_head.phone,
            national_finance_head.fellows.count,
            national_finance_head.coaches.count,
            national_finance_head.volunteers.count,
            national_finance_head.user.sign_in_count,
            national_finance_head.user.last_sign_in_at,
            national_finance_head.created_at,
            national_finance_head.updated_at
          ]
        end
      end
    end
  end
end
