class Reservation < ApplicationRecord

  has_one :order#, dependent: :destroy

  validates :user_id, presence: true

  validate :after_current?, :on => :create

  validate :after_current?, :on => :update

  validate :have_reservation?, :on => :create

#  validate :have_related_order?, :on => :destroy

  before_destroy :have_related_order?

  def after_current?
    return if checkout_time.blank?
    if checkout_time < reserve_time
      errors.add(:base, "You must be after the current time")
    end
  end

  def have_reservation?
    #  #check_reservation = Reservation.where(:user_id => self.user_id, :status => ["reserved", "checkedout"])
    check_reservation = Reservation.find_by_user_id_and_status(self.user_id, ["reserved", "checkedout"])
    if !check_reservation.nil?
      errors.add(:base, "You have unfinished reservation")
    end
  end

  def have_related_order?
    check_order = Order.find_by_reservation_id(self.id)
    #printf "++++++++++++++++++++++++++"
    #printf check_order.reservation_id
    if check_order.nil?
      return true
    else
      #printf "**************************"
      raise ActiveRecord::Rollback
      errors.add(:base, 'There are unfinished orders--')
      return false
    end
  end



end
