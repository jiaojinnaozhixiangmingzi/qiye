class PriceRulesController < ApplicationController
  before_action :set_price_rule, only: [:show, :edit, :update, :destroy]

  # GET /price_rules
  # GET /price_rules.json
  def index
  end

  # GET /price_rules/1
  # GET /price_rules/1.json
  def show
    @prices = @price_rule.category.prices.paginate(page: params[:page], per_page: 10)
  end

  # GET /price_rules/new
  def new
    @price_rule = PriceRule.new(category_id: params[:category])
  end

  # GET /price_rules/1/edit
  def edit
  end

  # POST /price_rules
  # POST /price_rules.json
  def create
    @price_rule = PriceRule.new(price_rule_params.merge(city_id: current_city.id))

    respond_to do |format|
      if @price_rule.save
        format.html { redirect_to @price_rule, notice: 'Price rule was successfully created.' }
        format.json { render :show, status: :created, location: @price_rule }
      else
        format.html { render :new }
        format.json { render json: @price_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /price_rules/1
  # PATCH/PUT /price_rules/1.json
  def update
    respond_to do |format|
      if @price_rule.update(price_rule_params)
        format.html { redirect_to @price_rule, notice: 'Price rule was successfully updated.' }
        format.json { render :show, status: :ok, location: @price_rule }
      else
        format.html { render :edit }
        format.json { render json: @price_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /price_rules/1
  # DELETE /price_rules/1.json
  def destroy
    @price_rule.destroy
    respond_to do |format|
      format.html { redirect_to price_rules_url, notice: 'Price rule was successfully destroyed.' }
      format.json { head :no_content }
    end
    end
  def getPriceRules
    rule = params[:city]
    @price_rules = PriceRule.find_by_sql(["select * from price_rules where price_rules.city_id = ? and price_rules.category_id
 = ? and price_rules.from_date < now() order by price_rules.from_date desc limit 1", params[:cityId], params[:categoryId]])
    respond_to do |format|
      if @price_rules.empty?
        format.json { render :json => {:data => "Get failed"}.to_json }
      else
        format.json { render :json => {:data => @price_rules}.to_json }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_price_rule
      @price_rule = PriceRule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def price_rule_params
      params.require(:price_rule).permit(:grade, :city_id, :category_id, :from_date)
    end
end
