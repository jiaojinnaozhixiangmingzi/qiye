class SettlementRulesController < ApplicationController
  before_action :set_settlement_rule, only: [:show, :edit, :update, :destroy, :refresh_products, :download, :upload]

  # GET /settlement_rules
  # GET /settlement_rules.json
  def index
    @settlement_rules = current_city.settlement_rules.paginate(page: params[:page], per_page: 10).order(updated_at: :desc)
  end

  # GET /settlement_rules/1
  # GET /settlement_rules/1.json
  def show
  end

  # GET /settlement_rules/new
  def new
    @settlement_rule = SettlementRule.new
  end

  # GET /settlement_rules/1/edit
  def edit
  end

  # POST /settlement_rules
  # POST /settlement_rules.json
  def create
    @settlement_rule = SettlementRule.new(settlement_rule_params.merge(city: current_city))

    respond_to do |format|
      if @settlement_rule.save
        format.html { redirect_to @settlement_rule, notice: 'Settlement rule was successfully created.' }
        format.json { render :show, status: :created, location: @settlement_rule }
      else
        format.html { render :new }
        format.json { render json: @settlement_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /settlement_rules/1
  # PATCH/PUT /settlement_rules/1.json
  def update
    respond_to do |format|
      if @settlement_rule.update(settlement_rule_params)
        format.html { redirect_to @settlement_rule, notice: 'Settlement rule was successfully updated.' }
        format.json { render :show, status: :ok, location: @settlement_rule }
      else
        format.html { render :edit }
        format.json { render json: @settlement_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /settlement_rules/1
  # DELETE /settlement_rules/1.json
  def destroy
    @settlement_rule.destroy
    respond_to do |format|
      format.html { redirect_to settlement_rules_url, notice: 'Settlement rule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def refresh_products
    @settlement_rule.category.products.each do |product|
      @settlement_rule.settlement_prices.create(product: product) if @settlement_rule.settlement_prices.where(product: product).empty?
    end
    redirect_to @settlement_rule
  end

  def download
    respond_to do |format|
      format.xlsx { response.headers['Content-Disposition'] = "attachment; filename='#{@settlement_rule.name}-加工商结算价格表.xlsx'"}
    end
  end

  def upload
    if request.post?
      p_l = Roo::Spreadsheet.open(params['settlement_rule']['file'].tempfile.path)
      
      sheet = p_l.sheet(0)
      l_c = p_l.last_column
      2.upto(p_l.last_row).each do |r|
        p_id = sheet.cell(r, 'A')
        p_name = sheet.cell(r, 'B')
        price = sheet.cell(r, 'C')

        settlement_price = @settlement_rule.settlement_prices.where(product_id: p_id).first
        
        if settlement_price
          settlement_price.update_attribute(:price, price)
        end
      end
      respond_to do |format|
        format.html { redirect_to @settlement_rule, notice: '结算价格更新成功！' }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_settlement_rule
      @settlement_rule = SettlementRule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def settlement_rule_params
      params.require(:settlement_rule).permit(:category_id, :city_id, :name, :comment)
    end
  end
