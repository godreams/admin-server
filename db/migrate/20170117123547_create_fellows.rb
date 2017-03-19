class CreateFellows < ActiveRecord::Migration[5.0]
  def change
    create_table :fellows do |t|
      t.references :user, foreign_key: true
      t.references :national_finance_head, foreign_key: true

      t.timestamps
    end
  end
end
