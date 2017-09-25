class CarsController < ApplicationController
  before_action :set_car, only: [:show, :edit, :update, :destroy]

  # GET /cars
  # GET /cars.json
  def index
    @user=User.all
    @cars = Car.all
  end

  # GET /cars/1
  # GET /cars/1.json
  def show
    @orders = Order.where(:car_id => params[:id]).order("created_at ASC")
  end

  # GET /cars/new
  def new
    @car = Car.new
  end

  # GET /cars/1/edit
  def edit
  end

  # POST /cars
  # POST /cars.json
  def create
    @car = Car.new(car_params)
    @car.status = "available"
    respond_to do |format|
      if @car.save
        format.html {redirect_to @car, notice: 'Car was successfully created.'}
        format.json {render :show, status: :created, location: @car}
      else
        format.html {render :new}
        format.json {render json: @car.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /cars/1
  # PATCH/PUT /cars/1.json
  def update
    respond_to do |format|
      if @car.update(car_params)
        format.html {redirect_to @car, notice: 'Car was successfully updated.'}
        format.json {render :show, status: :ok, location: @car}
      else
        format.html {render :edit}
        format.json {render json: @car.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /cars/1
  # DELETE /cars/1.json
  def destroy
    @car.destroy
    respond_to do |format|
      format.html {redirect_to cars_url, notice: 'Car was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  def who_bought
    @car=Car.find(params[:id])
    respond_to do |format|
      format.atom
      format.xml {render :xml => @car}
    end

  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_car
    @car = Car.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def car_params
    params.require(:car).permit(:title, :description, :image_url, :price, :status, :license_plate, :model, :manufactor, :style, :location )
  end
end
