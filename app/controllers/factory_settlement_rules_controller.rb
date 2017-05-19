class FactorySettlementRulesController < ApplicationController
  before_action :set_factory_settlement_rule, only: [:show, :edit, :update, :destroy]
  before_action :set_factory, only: [:show, :new, :create, :edit, :update, :destroy]

  # GET /factory_settlement_rules
  # GET /factory_settlement_rules.json
  def index
    @factory_settlement_rules = FactorySettlementRule.all
  end

  # GET /factory_settlement_rules/1
  # GET /factory_settlement_rules/1.json
  def show
  end

  # GET /factory_settlement_rules/new
  def new
    @factory_settlement_rule = FactorySettlementRule.new
  end

  # GET /factory_settlement_rules/1/edit
  def edit
  end

  # POST /factory_settlement_rules
  # POST /factory_settlement_rules.json
  def create
    @factory_settlement_rule = @factory.factory_settlement_rules.new(factory_settlement_rule_params)

    respond_to do |format|
      if @factory_settlement_rule.save
        format.html { redirect_to @factory, notice: 'Factory settlement rule was successfully created.' }
        format.json { render :show, status: :created, location: @factory_settlement_rule }
      else
        format.html { render :new }
        format.json { render json: @factory_settlement_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /factory_settlement_rules/1
  # PATCH/PUT /factory_settlement_rules/1.json
  def update
    respond_to do |format|
      if @factory_settlement_rule.update(factory_settlement_rule_params)
        format.html { redirect_to @factory, notice: 'Factory settlement rule was successfully updated.' }
        format.json { render :show, status: :ok, location: @factory_settlement_rule }
      else
        format.html { render :edit }
        format.json { render json: @factory_settlement_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /factory_settlement_rules/1
  # DELETE /factory_settlement_rules/1.json
  def destroy
    @factory_settlement_rule.destroy
    respond_to do |format|
      format.html { redirect_to @factory, notice: 'Factory settlement rule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_factory
    @factory = Factory.find(params[:factory_id])
  end
    # Use callbacks to share common setup or constraints between actions.
    def set_factory_settlement_rule
      @factory_settlement_rule = FactorySettlementRule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def factory_settlement_rule_params
      params.require(:factory_settlement_rule).permit(:from_date, :priority, :factory_id, :settlement_rule_id)
    end
end
