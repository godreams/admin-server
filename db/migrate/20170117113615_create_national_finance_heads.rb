class CreateNationalFinanceHeads < ActiveRecord::Migration[5.0]
  def change
    create_table :national_finance_heads do |t|
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
