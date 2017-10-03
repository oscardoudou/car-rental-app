class Order < ApplicationRecord
  PAYMENT_TYPES =["Check","Credit card","Purchase order"]
  CHECKOUT_DIRECT_START_NO = 2501
  validates :user_id, presence: true

  validate :have_order?, :on => :create

  validate :have_reservation?, :on => :create#只在create时校验

  validate :after_reserve_30?, :on => [:create, :update]

  validate :before_checkout_30?, :on => [:create, :update]

  def before_checkout_30?
   #if self.reservation_id < CHECKOUT_DIRECT_START_NO #checkout directly also fall in same situation
     #reservation = Reservation.find(self.reservation_id)
    if self.real_checkout_time < self.checkout_time - 24.hours
       errors.add(:id,"Checkout too early. Your could only checkout 1 day early.")
       # there is a bug here if
    end
  end

  def after_reserve_30? #here reserve actually refer to checkout time
    #if self.reservation_id < CHECKOUT_DIRECT_START_NO
      #reservation = Reservation.find(self.reservation_id)
      if self.real_checkout_time > self.checkout_time + 30.minutes
        errors.add(:id,"Reserve expired after 30min. Your should reserve again.")
        # sth else should be add
      end
  end

  def have_order?
    check_order = Order.find_by_user_id_and_status(self.user_id,["checkedout"])
    #judge statemnent should refine,now edit is unavailable cause this validation
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


