class Car < ApplicationRecord
  #default_scope :order => 'title'
  #has_many :line_items
  has_many :orders#, dependent: :destroy
  has_many :reservations
  validates_uniqueness_of :license_plate
  validates :license_plate, :length => {:is => 7}
  STYLE_TYPES =["Coupe", "Sedan", "SUV"]
  before_destroy :referenced_by_any_order?
  before_destroy :referenced_by_any_reservation?

  #Search cars using location or model or manufacturer or style or status
  def self.search(search1, search2, search3, search4, search5)
    where("location LIKE ? and model LIKE ? and manufactor LIKE ? and style LIKE ? and status LIKE ?", "%#{search1}%", "%#{search2}%", "%#{search3}%", "%#{search4}%", "%#{search5}%")
  end

  def referenced_by_any_reservation?
    check_reservation = Reservation.find_by_car_id_and_status(self.id, ["reserved", "checkedout"])
    if check_reservation.nil?
      return true
    else
      raise ActiveRecord::Rollback
      # errors.add(:base, 'There are unfinished reservations')
      return false
    end
  end

  def referenced_by_any_order?
    check_order = Order.find_by_car_id_and_status(self.id, ["checkedout"])
    if check_order.nil?
      return true
    else
      raise ActiveRecord::Rollback
      # errors.add(:base, 'There are unfinished orders')
      return false
    end
  end




end
