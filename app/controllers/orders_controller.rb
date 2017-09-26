class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
    if logged_in?
      if current_user.admin?
        @orders = Order.all
      else
        #@orders=Order.where(:email => current_user.email)
        @orders=Order.where(:user_id => current_user.id)
      end
    else
      @orders=[]
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new

    @order = Order.new

    if params.key?(:reservation_id)
    reservation = Reservation.find(params[:reservation_id])
    #reservation.status = 'checkout'
    @order.reservation_id = reservation.id
    @order.name = reservation.name
    @order.car_id = reservation.car_id
    @order.email = reservation.email
    @order.address = reservation.address
    else
      @order.reservation_id = 2500
      @order.real_checkout_time = Time.now
      car = Car.find(params[:car_id])
      @order.car_id = car.id
     # render "orders/new"
    end

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

    @order = Order.new(order_params)
    car = Car.find(@order.car_id)
    if @order.reservation_id != 2500
      reservation = Reservation.find(@order.reservation_id)
    else
      @order.return_time = @order.real_checkout_time+Integer(order_params[:return_time]).hours
    end

    if current_user != nil # 有必要判断吗？
      @order.user_id = current_user.id
    end

    @order.status = 'checked out'
    # @order = Order.new(order_params)
    # @order.add_line_items_from_reservation(current_reservation)
    #@order.name= '12345'
    #@order.name=reservation.name
    #@order.car_id=reservation.car_id
    #@order.address=reservation.address
    #@order.email=reservation.email
    #@order.status='checked out'
    #@order.real_checkout_time = Time.now
    #end

    respond_to do |format|
      if @order.save
        car.update_attribute(:status, 'checked out')
        if @order.reservation_id != 2500
          reservation.update_attribute(:status, 'checked out')
        end
        ##reservation.update_attribute('status','checkout')
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
    car = Car.find(@order.car_id)
    car.update_attribute('status','availbale')
    if @order.reservation_id != 2500
      reservation = Reservation.find(@order.reservation_id)
      reservation.update_attribute('status','reserved')
    end
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
      params.require(:order).permit(:name, :address, :email, :pay_type, :reservation_id, :car_id , :tel ,:real_checkout_time,:return_time)
    end
end
