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
      t.timestamp :reserve_time
      t.timestamp :checkout_time
      t.timestamp :return_time

      t.timestamps
    end
  end
end
