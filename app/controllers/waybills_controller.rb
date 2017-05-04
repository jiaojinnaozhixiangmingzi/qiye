class WaybillsController < ApplicationController
  before_action :set_waybill, only: [:show, :edit, :update, :destroy]

  # GET /waybills
  # GET /waybills.json
  def index
    @waybills = Waybill.all
  end

  # GET /waybills/1
  # GET /waybills/1.json
  def show
  end

  # GET /waybills/new
  def new
    @waybill = Waybill.new
  end

  # GET /waybills/1/edit
  def edit
  end

  # POST /waybills
  # POST /waybills.json
  def create
    @waybill = Waybill.new(waybill_params)

    respond_to do |format|
      if @waybill.save
        format.html { redirect_to @waybill, notice: 'Waybill was successfully created.' }
        format.json { render :show, status: :created, location: @waybill }
      else
        format.html { render :new }
        format.json { render json: @waybill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /waybills/1
  # PATCH/PUT /waybills/1.json
  def update
    respond_to do |format|
      if @waybill.update(waybill_params)
        format.html { redirect_to @waybill, notice: 'Waybill was successfully updated.' }
        format.json { render :show, status: :ok, location: @waybill }
      else
        format.html { render :edit }
        format.json { render json: @waybill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /waybills/1
  # DELETE /waybills/1.json
  def destroy
    @waybill.destroy
    respond_to do |format|
      format.html { redirect_to waybills_url, notice: 'Waybill was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def fightWaybill
    @waybill = WayBill.find_by_sql(["SELECT * FROM orders where status = '0' AND address_id = (SELECT id FROM
addresses WHERE addressable_type = 'station' AND addressable_id = (SELECT station_id from couriers_stations where
courier_id = ?))", params[:courierId]])
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
    def set_waybill
      @waybill = Waybill.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def waybill_params
      params.require(:waybill).permit(:status, :sender_type, :sender_id, :receiver_type, :receiver_id, :exp_time,
                                      :actual_time, :order_id)
      end

    def create_waybill_params
      params.require(:waybill).permit(:sender_type, :sender_id, :receiver_type, :receiver_id, :order_id)
    end
end
