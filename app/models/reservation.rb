class Reservation < ApplicationRecord

  validates :user_id, presence: true

  validate :after_current?

  validate :have_reservation?

  def after_current?
    return if checkout_time.blank?
    if checkout_time < reserve_time
      errors.add(:checkout_time, "must be after the current time")
    end
  end

  def have_reservation?
    check_reservation = Reservation.find_by_user_id(self.user_id)
    if !check_reservation.nil?
      errors.add(:id, "you have unfinished reservation")
    end
  end

end
