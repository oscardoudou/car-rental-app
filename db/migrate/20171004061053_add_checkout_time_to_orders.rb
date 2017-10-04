class AddCheckoutTimeToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :checkout_time, :timestamp
  end
end
