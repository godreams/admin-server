class CreateDonations < ActiveRecord::Migration[5.0]
  def change
    create_table :donations do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.integer :amount
      t.string :pan
      t.text :address
      t.references :volunteer, foreign_key: true

      t.timestamps
    end
  end
end
