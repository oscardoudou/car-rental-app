class StoreController < ApplicationController
  def index()
    #index the cars that are available

    @cars = Car.where( :status => 'available').order("created_at ASC")

    if params[:search1] or params[:search2]
      @cars = Car.search(params[:search1], params[:search2]).order("created_at DESC")
    else
      @cars = Car.where( :status => 'available').order("created_at ASC")
    end

  end
end
