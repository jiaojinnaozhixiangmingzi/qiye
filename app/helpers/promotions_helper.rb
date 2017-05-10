module PromotionsHelper
  def show_promotion_kind(promotion)
    case promotion.kind
    when 0
      '直减'
    when 1
      '满减'
    when 2
      '打折'
    when 3
      '特价'
    end
  end

  def show_promotion_content(promotion)
    case promotion.kind
    when 0
      "满 #{promotion.premise} 减 #{promotion.discount}"
    when 1
      "每满 #{promotion.premise} 减 #{promotion.discount}"
    when 2
      "满 #{promotion.premise} 打 #{promotion.discount} 折"
    when 3
      "满 #{promotion.premise} 只需 #{promotion.discount}"
    end
  end

  def show_user_promotion_kind(promotion)
    case promotion.kind
    when 0
      '新用户优惠'
    when 1
      '老用户优惠'
    end
  end

  def show_user_promotion_content(promotion)
    case promotion.kind
    when 0
      "新用户优惠 #{promotion.discount}"
    when 1
      "老用户优惠 #{promotion.discount}"
    end
  end


  def show_category_promotion_kind(promotion)
    case promotion.kind
    when 0
      '衬衫优惠'
    when 1
      '夹克优惠'
    end
  end

  def show_category_promotion_content(promotion)
    case promotion.kind
    when 0
      "折扣价 #{promotion.discount}"
    when 1
      "折扣价 #{promotion.discount}"
    end
  end
end


