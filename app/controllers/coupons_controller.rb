class CouponsController < ApplicationController
  # load_and_authorize_resource
  
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

  def createCoupon
    @CouponLists = CouponList.find_by_sql(["SELECT * FROM coupon_lists WHERE id = ?;", params[:couponListId]])
    @CouponList = @CouponLists[0]
    @Coupon = Coupon.create(coupon_list_id: @CouponList.id, user_id: params[:userId], valid_from: @CouponList
                                                                                                      .valid_from,
                            valid_to: @CouponList.valid_to, used: 0)
    respond_to do |format|
      if @Coupon.save
        format.html { redirect_to @Coupon, notice: 'Item was successfully created.' }
        format.json { render :json => {:data => @Coupon}.to_json }
      else
        format.html { render :new }
        format.json { render json: @Coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  def getUsedCoupon
    @OrderPromotion = OrderPromotion.find_by_sql(["SELECT * FROM order_promotions where coupon_list_id IN (SELECT
coupon_list_id FROM coupons WHERE used = 1 and user_id = ?);", params[:userId]])
    @UserPromotion = UserPromotion.find_by_sql(["SELECT * FROM user_promotions where coupon_list_id IN (SELECT
coupon_list_id FROM coupons WHERE used = 1 and user_id = ?);", params[:userId]])
    @CategoryPromotion = CategoryPromotion.find_by_sql(["SELECT * FROM category_promotions where coupon_list_id IN
(SELECT coupon_list_id FROM coupons WHERE used = 1 and user_id = ?);", params[:userId]])
    respond_to do |format|
      format.json { render :json => {:orderPromotion => @OrderPromotion, :userPromotion => @UserPromotion,
                                     :categoryPromotion => @CategoryPromotion}.to_json }
    end
  end

  def getUnusedCoupon
    @OrderPromotion = OrderPromotion.find_by_sql(["SELECT * FROM order_promotions where coupon_list_id IN (SELECT
coupon_list_id FROM coupons WHERE used = 0 and valid_to >= NOW() and user_id = ?);", params[:userId]])
    @UserPromotion = UserPromotion.find_by_sql(["SELECT * FROM user_promotions where coupon_list_id IN (SELECT
coupon_list_id FROM coupons WHERE used = 0 and valid_to >= NOW() and user_id = ?);", params[:userId]])
    @CategoryPromotion = CategoryPromotion.find_by_sql(["SELECT * FROM category_promotions where coupon_list_id IN
(SELECT coupon_list_id FROM coupons WHERE used = 0 and valid_to >= NOW() and user_id = ?);", params[:userId]])
    respond_to do |format|
      format.json { render :json => {:orderPromotion => @OrderPromotion, :userPromotion => @UserPromotion,
                                     :categoryPromotion => @CategoryPromotion}.to_json }
    end
  end

  def getInvalidCoupon
    @Coupons = Coupon.find_by_sql(["SELECT * FROM coupons WHERE used = 0 and valid_to < NOW() and user_id = ?;",
                                   params[:userId]])
    @OrderPromotion = OrderPromotion.find_by_sql(["SELECT * FROM order_promotions where coupon_list_id IN (SELECT
coupon_list_id FROM coupons WHERE used = 0 and valid_to < NOW() and user_id = ?);", params[:userId]])
    @UserPromotion = UserPromotion.find_by_sql(["SELECT * FROM user_promotions where coupon_list_id IN (SELECT
coupon_list_id FROM coupons WHERE used = 0 and valid_to < NOW() and user_id = ?);", params[:userId]])
    @CategoryPromotion = CategoryPromotion.find_by_sql(["SELECT * FROM category_promotions where coupon_list_id IN
(SELECT coupon_list_id FROM coupons WHERE used = 0 and valid_to < NOW() and user_id = ?);", params[:userId]])
    respond_to do |format|
      format.json { render :json => {:orderPromotion => @OrderPromotion, :userPromotion => @UserPromotion,
                                     :categoryPromotion => @CategoryPromotion}.to_json }
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
