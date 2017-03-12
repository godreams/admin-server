class NationalFinanceHeadsController < ApplicationController
  def index
    authorize NationalFinanceHead
    @national_finance_heads = NationalFinanceHead.all
  end
end
