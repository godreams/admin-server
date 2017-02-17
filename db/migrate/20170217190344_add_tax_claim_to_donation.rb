class AddTaxClaimToDonation < ActiveRecord::Migration[5.0]
  def change
    add_column :donations, :tax_claim, :boolean, default: false
  end
end
