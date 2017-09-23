class LineItem < ApplicationRecord
  # the following code need to be changed
  #belongs_to :order
  belongs_to :car
  belongs_to :reservation

  def total_price
    car.price*quantity
  end
end
