class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|

      t.string :name
      t.text :address
      t.string :email
      t.integer :car_id
      t.integer :user_id
      t.integer :tel
      t.string :status
      t.date :reserve_time
      t.date :checkout_time
      t.date :return_time

      t.timestamps
    end
  end
end
