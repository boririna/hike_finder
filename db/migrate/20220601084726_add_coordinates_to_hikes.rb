class AddCoordinatesToHikes < ActiveRecord::Migration[6.1]
  def change
    add_column :hikes, :latitude, :float
    add_column :hikes, :longitude, :float
  end
end
