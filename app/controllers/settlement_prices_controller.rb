class SettlementPricesController < ApplicationController
  before_action :set_settlement_price, only: [:show, :edit, :update, :destroy]

  # GET /settlement_prices
  # GET /settlement_prices.json
  def index
    @settlement_prices = SettlementPrice.all
  end

  # GET /settlement_prices/1
  # GET /settlement_prices/1.json
  def show
  end

  # GET /settlement_prices/new
  def new
    @settlement_price = SettlementPrice.new
  end

  # GET /settlement_prices/1/edit
  def edit
  end

  # POST /settlement_prices
  # POST /settlement_prices.json
  def create
    @settlement_price = SettlementPrice.new(settlement_price_params)

    respond_to do |format|
      if @settlement_price.save
        format.html { redirect_to @settlement_price, notice: 'Settlement price was successfully created.' }
        format.json { render :show, status: :created, location: @settlement_price }
      else
        format.html { render :new }
        format.json { render json: @settlement_price.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /settlement_prices/1
  # PATCH/PUT /settlement_prices/1.json
  def update
    respond_to do |format|
      if @settlement_price.update(settlement_price_params)
        format.html { redirect_to @settlement_price, notice: 'Settlement price was successfully updated.' }
        format.json { render :show, status: :ok, location: @settlement_price }
      else
        format.html { render :edit }
        format.json { render json: @settlement_price.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /settlement_prices/1
  # DELETE /settlement_prices/1.json
  def destroy
    @settlement_price.destroy
    respond_to do |format|
      format.html { redirect_to settlement_prices_url, notice: 'Settlement price was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_settlement_price
      @settlement_price = SettlementPrice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def settlement_price_params
      params.require(:settlement_price).permit(:settlement_rule_id, :product_id, :price)
    end
end
