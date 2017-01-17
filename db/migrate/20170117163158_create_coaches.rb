class CreateCoaches < ActiveRecord::Migration[5.0]
  def change
    create_table :coaches do |t|
      t.integer :user_id
      t.integer :fellow_id

      t.timestamps
    end
    add_index :coaches, :fellow_id
  end
end
