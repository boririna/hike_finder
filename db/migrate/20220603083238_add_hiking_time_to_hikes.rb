class AddHikingTimeToHikes < ActiveRecord::Migration[6.1]
  def change
    add_column :hikes, :hiking_time, :string
  end
end
