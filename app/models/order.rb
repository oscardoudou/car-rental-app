class Order < ApplicationRecord
  PAYMENT_TYPES =["Check","Credit card","Purchase order"]
  CHECKOUT_DIRECT_START_NO = 2501
  validates :user_id, presence: true

  validate :have_order?

  validate :have_reservation?
  def have_order?
    check_order = Order.find_by_user_id_and_status(self.user_id,["checkedout"])
    unless check_order.nil?
      errors.add(:id, "you have unfinished order")
    end
  end

  def have_reservation?

    if self.reservation_id < CHECKOUT_DIRECT_START_NO
      # make sure normal user who just have a "reserved" reservation that have no checkedout reservation.
      check_reservation = Reservation.find_by_user_id_and_status(self.user_id,["checkedout"])
    else
      # those who want to checkout directly dont have "unreturned"" reservation in either status.
      check_reservation = Reservation.find_by_user_id_and_status(self.user_id,["reserved","checkedout"])
    end

    if  !check_reservation.nil?
      errors.add(:id, "you have unfinished reservation")
    end
  end
end


