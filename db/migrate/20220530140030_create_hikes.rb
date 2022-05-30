class CreateHikes < ActiveRecord::Migration[6.1]
  def change
    create_table :hikes do |t|
      t.string :name
      t.string :description
      t.string :difficulty_level
      t.integer :length
      t.integer :ascent
      t.integer :descent
      t.string :services
      t.boolean :dog_friendly

      t.timestamps
    end
  end
end
