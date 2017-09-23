class Reservation < ApplicationRecord
  #this code need to be changed, one user can only reserve one car one time
  #has_many :line_items, :dependent => :destroy
  has_many :line_items, :dependent => :destroy
  def add_car(car_id)
    current_item= line_items.find_by_car_id(car_id)
    if current_item
      current_item.quantity +=1
    else
      current_item = line_items.build(:car_id=>car_id)
    end
    current_item
  end

=begin
  def add_car(car_id)
    current_item= line_items.find_by_car_id(car_id)
    if current_item
      current_item.quantity +=1
    else
      current_item = line_items.build(:car_id=>car_id)
    end
    current_item
  end
=end
end
