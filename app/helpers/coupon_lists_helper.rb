module CouponListsHelper
  def show_coupon_list_valid_type(validity_type)
    case validity_type
    when 0
      '绝对有效期'
    when 1
      '相对有效期'
    end
  end

  def show_coupon_list_valid(coupon_list)
    case coupon_list.validity_type
    when 0
      "从 #{coupon_list.valid_from} 到 #{coupon_list.valid_to}"
    when 1
      "领取后 #{coupon_list.fixed_begin_term} 天生效，有效期 #{coupon_list.fixed_term} 天"
    end
  end

  def show_coupon_list_promotion_type(coupon_list)
    case coupon_list.promotion_type
    when 'CategoryPromotion'
      '品类优惠'
    when 'OrderPromotion'
      '整单优惠'
    when 'CustomerPromotion'
      '用户等级优惠'
    end
  end
end
