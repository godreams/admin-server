class CreateApprovals < ActiveRecord::Migration[5.0]
  def change
    create_table :approvals do |t|
      t.references :donation, foreign_key: true
      t.references :approver, polymorphic: true

      t.timestamps
    end
  end
end
