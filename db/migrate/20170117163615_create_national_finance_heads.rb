class CreateNationalFinanceHeads < ActiveRecord::Migration[5.0]
  def change
    create_table :national_finance_heads do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
