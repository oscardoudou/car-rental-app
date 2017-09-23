class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
=begin
    if @reservation.nil?
      redirect_to store_url, :notice => "You have no reservation"
      return
    end
=end

    @order = Order.new
    respond_to do |format|
      format.html
      format.xml {render :xml => @order}
    end
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create

    @order = Order.new()
    reservation = Reservation.find(params[:reservation_id])
    # @order = Order.new(order_params)
    # @order.add_line_items_from_reservation(current_reservation)
@order.name= '12345'
    @order.name=reservation.name
    @order.car_id=reservation.car_id
    @order.address=reservation.address
    @order.email=reservation.email
    @order.status='checked out'

    respond_to do |format|
      if @order.save
        # Reservation.destroy(session[:reservation_id])
        # session[:reservation_id]=nil
        format.html { redirect_to store_url, notice: 'Thank you for your order.' }

        #format.html { redirect_to (store_url, notice: 'Thank you for your order.' )}
        # format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:name, :address, :email, :pay_type, :reservation_id)
    end
end
