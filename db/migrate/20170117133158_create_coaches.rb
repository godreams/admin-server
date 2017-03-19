class CreateCoaches < ActiveRecord::Migration[5.0]
  def change
    create_table :coaches do |t|
      t.references :user, foreign_key: true
      t.references :fellow, foreign_key: true

      t.timestamps
    end
  end
end
