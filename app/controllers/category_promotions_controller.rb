class CategoryPromotionsController < ApplicationController
  before_action :set_coupon_list, only: [:new, :edit, :create, :update, :destroy, :show]
  # load_and_authorize_resource

  def new
    @category_promotion = CategoryPromotion.new
  end

  def create
    @category_promotion = @coupon_list.category_promotions.create(resource_params)
    respond_to do |format|
      if @category_promotion.save
        format.html { redirect_to @coupon_list, notice: 'category promotion was successfully created.' }
        format.json { render :show, status: :created, location: @category_promotion }
      else
        format.html { render :new }
        format.json { render json: @category_promotion.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @category_promotion.update(resource_params)
        format.html { redirect_to @coupon_list, notice: 'category promotion was successfully updated.' }
        format.json { render :show, status: :ok, location: @category_promotion }
      else
        format.html { render :edit }
        format.json { render json: @category_promotion.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category_promotion.destroy
    respond_to do |format|
      format.html { redirect_to @coupon_list, notice: 'category promotion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_coupon_list
    @coupon_list = CouponList.find(params[:coupon_list_id])
  end
  
  def resource_params
    params.require(:category_promotion).permit(:name, :kind, :discount, :premise)
  end
end
