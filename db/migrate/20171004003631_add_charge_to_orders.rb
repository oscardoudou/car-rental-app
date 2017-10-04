class AddChargeToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :charge, :decimal, precision: 8, scale: 2
  end
end
