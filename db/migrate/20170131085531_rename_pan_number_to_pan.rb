class RenamePanNumberToPan < ActiveRecord::Migration[5.0]
  def change
    rename_column :donations, :pan_number, :pan
  end
end
