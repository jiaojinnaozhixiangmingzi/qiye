class PromotionRulesController < ApplicationController
  before_action :set_coupon_list, only: [:new, :edit, :create, :update, :destroy, :show]
  # load_and_authorize_resource
  
  def create
    @promotion_rule = @coupon_list.promotion_rules.create(resource_params)
    respond_to do |format|
      if @promotion_rule.save
        format.html { redirect_to @coupon_list, notice: 'Promotion rule was successfully created.' }
        format.json { render :show, status: :created, location: @promotion_rule }
      else
        format.html { render :new }
        format.json { render json: @promotion_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def update
    respond_to do |format|
      if @promotion_rule.update(resource_params)
        format.html { redirect_to @coupon_list, notice: 'Promotion rule was successfully updated.' }
        format.json { render :show, status: :ok, location: @promotion_rule }
      else
        format.html { render :edit }
        format.json { render json: @promotion_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def destroy
    @promotion_rule.destroy
    respond_to do |format|
      format.html { redirect_to @coupon_list, notice: 'Promotion rule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_coupon_list
    @coupon_list = CouponList.find(params[:coupon_list_id])
  end

  def resource_params
    params.require(:promotion_rule).permit(:start_on, :end_on, city_ids: [])
  end
end
