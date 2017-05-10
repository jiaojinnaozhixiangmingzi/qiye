class OrderPromotionsController < ApplicationController
  before_action :set_coupon_list, only: [:new, :edit, :create, :update, :destroy, :show]
  load_and_authorize_resource

  def create
    @order_promotion = @coupon_list.order_promotions.create(resource_params)
    respond_to do |format|
      if @order_promotion.save
        format.html { redirect_to @coupon_list, notice: 'Order promotion was successfully created.' }
        format.json { render :show, status: :created, location: @order_promotion }
      else
        format.html { render :new }
        format.json { render json: @order_promotion.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @order_promotion.update(resource_params)
        format.html { redirect_to @coupon_list, notice: 'Order promotion was successfully updated.' }
        format.json { render :show, status: :ok, location: @order_promotion }
      else
        format.html { render :edit }
        format.json { render json: @order_promotion.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @order_promotion.destroy
    respond_to do |format|
      format.html { redirect_to @coupon_list, notice: 'Order promotion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_coupon_list
    @coupon_list = CouponList.find(params[:coupon_list_id])
  end
  
  def resource_params
    params.require(:order_promotion).permit(:name, :kind, :discount, :premise)
  end
end
