class UserPromotionsController < ApplicationController
  before_action :set_coupon_list, only: [:new, :edit, :create, :update, :destroy, :show]
  # load_and_authorize_resource

  def new
    @user_promotion = UserPromotion.new
  end

  def create
    @user_promotion = @coupon_list.user_promotions.create(resource_params)
    respond_to do |format|
      if @user_promotion.save
        format.html { redirect_to @coupon_list, notice: 'user promotion was successfully created.' }
        format.json { render :show, status: :created, location: @user_promotion }
      else
        format.html { render :new }
        format.json { render json: @user_promotion.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user_promotion.update(resource_params)
        format.html { redirect_to @coupon_list, notice: 'user promotion was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_promotion }
      else
        format.html { render :edit }
        format.json { render json: @user_promotion.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user_promotion.destroy
    respond_to do |format|
      format.html { redirect_to @coupon_list, notice: 'user promotion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_coupon_list
    @coupon_list = CouponList.find(params[:coupon_list_id])
  end
  
  def resource_params
    params.require(:user_promotion).permit(:name, :kind, :discount, :premise)
  end
end
