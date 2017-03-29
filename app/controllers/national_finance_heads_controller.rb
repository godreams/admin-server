class NationalFinanceHeadsController < ApplicationController
  def index
    authorize NationalFinanceHead
    @national_finance_heads = NationalFinanceHead.all.includes(:user)

    respond_to do |format|
      format.html
      format.csv { render csv: @national_finance_heads, filename: "national_finance_heads_#{Time.now.strftime('%Y%m%d_%H%M%S')}" }
    end
  end
end
