class Order < ApplicationRecord
  PAYMENT_TYPES =["Check","Credit card","Purchase order"]
=begin
  def add_line_items_from_reservation(reservation)
    reservation.line_items.each do |item|
      item.reservation_id = nil
      line_items << item
    end
  end
=end
end
