class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :paidan, :pay]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.paginate(page: params[:page], per_page: 10).order(updated_at: :desc)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :json => {:data => @order}.to_json }
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

  def pay
    respond_to do |format|
      userCardLog = @order.pay_it
      @Coupons = Coupon.find_by_sql(["SELECT * FROM coupons WHERE coupon_list_id = ? and user_id = ?;",
                                     params[:couponListId], params[:userId]])
      @Coupon = @Coupons[0]
      @Coupon.update_attributes(:used => 1)
      if userCardLog == nil
        format.json { render :json => {:data => "Pay failed"}.to_json }
      else
        format.json { render :json => {:data => "Pay succ"}.to_json }
      end
    end
  end

  def paidan
    @order.paidan
    respond_to do |format|
      format.html { redirect_to @order, notice: 'Order was successfully destroyed.' }
    end
    end

  def sendOrder
    @orders = Order.find_by_sql(["SELECT * FROM orders where status = '0' AND factory_id in (SELECT factory_id FROM
factories_stations WHERE station_id in (SELECT station_id from couriers_stations where courier_id = ?)) ORDER BY
created_at desc", params[:courierId]])
    respond_to do |format|
      if @orders.empty?
        format.json { render :json => {:data => "Get failed"}.to_json }
      else
        format.json { render :json => {:data => @orders}.to_json }
      end
    end
  end

  def createOrder
    @order = Order.new(create_order_params)
    respond_to do |format|
      if @order.save
        factoryId = @order.findFactory
        @wayBill = @order.createWaybill
        address = @order.findAddress
        @voucher = @order.create_voucher
        @voucher.update_attributes(:money => @order.total_price)
        @order.update_attributes(:factory_id => factoryId)
        @order.update_attributes(:waybill_id => @wayBill.id)
        format.json { render :json => {:data => @order, :address => address}.to_json }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
    end

  def getOrderByUser
    @orders = Order.find_by_sql(["SELECT * FROM orders where user_id = ? ORDER BY created_at desc", params[:userId]])
    respond_to do |format|
      if @orders.empty?
        format.json { render :json => {:data => "Get failed"}.to_json }
      else
        format.json { render :json => {:data => @orders}.to_json }
      end
    end
  end

  def getOrderByCourier
    @orders = Order.find_by_sql(["SELECT * FROM orders WHERE id in (SELECT order_id FROM waybills WHERE sender_type =
 'Courier' AND sender_id =?) ORDER BY courier_status;", params[:courierId]])
    respond_to do |format|
      if @orders.empty?
        format.json { render :json => {:data => "Get failed"}.to_json }
      else
        format.json { render :json => {:data => @orders}.to_json }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:category_id, :user_id, :address_id, :total_price, :status, :courier_status, :voucher_status, :cleaning_status)
      end
    def create_order_params
      params.permit(:category_id, :user_id, :address_id, :total_price, :status, :courier_status, :voucher_status, :cleaning_status)
    end
end
