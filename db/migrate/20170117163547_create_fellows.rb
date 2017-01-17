class CreateFellows < ActiveRecord::Migration[5.0]
  def change
    create_table :fellows do |t|
      t.integer :user_id
      t.integer :national_finance_head_id

      t.timestamps
    end
    add_index :fellows, :national_finance_head_id
  end
end
