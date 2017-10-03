class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  @@reservationid = Order::CHECKOUT_DIRECT_START_NO

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
    #@order.return_time = reservation.return_time
   # @order.checkout_time = reservation.checkout_time ## should be written here but I move it into create,more info see create
      #view corresponding form should be read only
    else
      @@reservationid += 1
      @order.reservation_id = @@reservationid
     # @order.real_checkout_time = Time.now
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
    @order.real_checkout_time = Time.now
    if @order.reservation_id < Order::CHECKOUT_DIRECT_START_NO
      reservation = Reservation.find(@order.reservation_id)
      @order.return_time = reservation.return_time
      @order.checkout_time = reservation.checkout_time # still dont know why should add this line as it should not be here, database refresh is slow may be the reason
    else
      @order.return_time = @order.checkout_time+Integer(order_params[:return_time]).hours
    end

    if current_user != nil # 有必要判断吗？
      @order.user_id = current_user.id
    end

    @order.status = 'checkedout'
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
        car.update_attribute(:status, 'checkedout')
        if @order.reservation_id < Order::CHECKOUT_DIRECT_START_NO
          reservation.update_attribute(:status, 'checkedout')
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
    @order = Order.find(params[:id])
    @order.update_attribute('status','returned')
    @order.update_attribute('real_return_time',Time.now)
    car = Car.find(@order.car_id)
    car.update_attribute('status','available')
    if @order.reservation_id < Order::CHECKOUT_DIRECT_START_NO
    reservation = Reservation.find(@order.reservation_id)
    reservation.update_attribute('status','returned')
    end
    respond_to do |format|
      #if @order.save
   #   if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully returned.' }
        format.json { render :show, status: :ok, location: @order }
     # else
       # format.html { render :edit }
        #format.json { render json: @order.errors, status: :unprocessable_entity }
      #end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    car = Car.find(@order.car_id)
    car.update_attribute('status','available')
    if @order.reservation_id < Order::CHECKOUT_DIRECT_START_NO
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
      params.require(:order).permit(:name, :address, :email, :pay_type, :reservation_id, :car_id , :tel ,:real_checkout_time,:return_time,:checkout_time)
    end

end
