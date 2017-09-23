class StoreController < ApplicationController
  def index
    #index the cars that are available

    @cars = Car.where( :status => 'available')
  end
end
