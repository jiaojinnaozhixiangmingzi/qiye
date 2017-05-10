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
end
