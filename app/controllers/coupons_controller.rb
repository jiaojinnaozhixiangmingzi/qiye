class CouponsController < ApplicationController
  load_and_authorize_resource
  
  before_action :set_user, only: [:new, :create, :destroy]

  def create
    @coupon = @user.coupons.create(coupon_params)

    respond_to do |format|
      if @coupon.save
        format.html { redirect_to @user, notice: 'Coupon was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def destroy
    @coupon.destroy
    respond_to do |format|
      format.html { redirect_to @user, notice: 'Coupon was successfully destroyed.' }
    end
  end

  private
  def set_user
    @user = User.find(params[:user_id])
  end

  def coupon_params
    params.require(:coupon).permit(:coupon_list_id)
  end
end
