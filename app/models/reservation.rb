class Reservation < ApplicationRecord
  #this code need to be changed, one user can only reserve one car one time
  #has_many :line_items, :dependent => :destroy
=begin
  validates :after_current

  def after_current
    return if :checkout_time.blank?

    if :checkout_time < :reserve_time
      errors.add(:checkout_time, "must be after the start date")
    end
  end
=end

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
