class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|



      t.string :name
      t.text :address
      t.string :email
      t.string :pay_type
      t.integer :car_id
      t.integer :user_id
      t.integer :reservation_id
      t.integer :tel
      t.string :status
      t.timestamp :real_return_time
      t.timestamp :real_checkout_time
      t.timestamp :return_time



      t.timestamps
    end
  end
end
