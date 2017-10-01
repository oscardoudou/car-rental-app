class Reservation < ApplicationRecord

  validates :user_id, presence: true

  validate :after_current?

  validate :have_reservation?

  validate :have_order?

  def after_current?
    return if checkout_time.blank?
    if checkout_time < reserve_time
      errors.add(:checkout_time, "must be after the current time")
    end
  end

  def have_reservation?
  #  #check_reservation = Reservation.where(:user_id => self.user_id, :status => ["reserved", "checkedout"])
    check_reservation = Reservation.find_by_user_id_and_status(self.user_id, ["reserved", "checkedout"])
    if !check_reservation.nil?
      errors.add(:id, "you have unfinished reservation")
    end
  end

  def have_order?
    check_order = Order.find_by_user_id_and_status(self.user_id,["checkedout"])
    unless check_order.nil?
      errors.add(:id, "you have unfinished order")
    end
  end

end
