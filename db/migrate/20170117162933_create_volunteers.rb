class CreateVolunteers < ActiveRecord::Migration[5.0]
  def change
    create_table :volunteers do |t|
      t.integer :user_id
      t.integer :coach_id

      t.timestamps
    end
    add_index :volunteers, :coach_id
  end
end
