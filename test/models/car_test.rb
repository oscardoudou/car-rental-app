require 'test_helper'

class CarTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

   test  "license_plate length should be 7 "do
     car   = Car.new()
     car.license_plate = 'XX0000'
     assert_not car.save
   end

   test  "license_plate length should be unique "do
     car = Car.new()
     car.license_plate = 'XX00001'
     assert_not car.save
   end

   test  "car with 7 bit length and unqie license_plate should be saved "do
     car = Car.new()
     car.license_plate = 'XX00003'
     assert car.save
   end
end
