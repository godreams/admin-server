class CreateDonations < ActiveRecord::Migration[5.0]
  def change
    create_table :donations do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.integer :amount
      t.string :pan_number
      t.text :address

      t.timestamps
    end
  end
end
