class CreateLineItems < ActiveRecord::Migration[5.1]
  def change
    create_table :line_items do |t|
      t.integer :car_id
      t.integer :reservation_id

      t.timestamps
    end
  end
end
