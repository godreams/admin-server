class AddCityToFellows < ActiveRecord::Migration[5.0]
  def change
    add_reference :fellows, :city, foreign_key: true
  end
end
