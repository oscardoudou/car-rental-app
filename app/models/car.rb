class Car < ApplicationRecord
  #default_scope :order => 'title'
  has_many :line_items
  has_many :orders, :through => :line_items
  has_many :reservation
  validates_uniqueness_of :license_plate
  validates :license_plate, :length => { :is => 7 }
  STYLE_TYPES =["Coupe","Sedan","SUV"]
  before_destroy :ensure_not_referenced_by_any_line_item
  private
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base,'Line Items present')
      return false
    end
  end
end
