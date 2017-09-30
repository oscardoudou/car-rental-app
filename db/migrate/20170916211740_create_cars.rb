class CreateCars < ActiveRecord::Migration[5.1]
  def change
    create_table :cars do |t|
      t.string :title
      t.text :description
      t.string :image_url
      t.decimal :price, :precision=>8, :scale=>2
      t.string :status
      t.string :license_plate
      t.string :model
      t.string :manufactor
      t.string :style
      t.string :location

      t.timestamps
    end
  end
  def self.down
    drop_table :cars
  end
end
