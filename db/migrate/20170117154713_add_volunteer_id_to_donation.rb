class AddVolunteerIdToDonation < ActiveRecord::Migration[5.0]
  def change
    add_column :donations, :volunteer_id, :integer
    add_index :donations, :volunteer_id
  end
end
