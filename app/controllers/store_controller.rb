class StoreController < ApplicationController
  def index()
    #index the cars that are available

    @cars = Car.all.order("created_at ASC")

    if params[:search1] or params[:search2] or params[:search3] or params[:search4] or params[:search5]
      @cars = Car.search(params[:search1], params[:search2], params[:search3], params[:search4], params[:search5]).order("created_at DESC")
    else
      @cars = Car.all.order("created_at ASC")
    end

  end
end
