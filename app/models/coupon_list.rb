class CouponList < ApplicationRecord
  has_many :order_promotions
  has_many :promotion_rules

  def self.can_be_assigns
    today = Date.today
    CouponList.joins(:promotion_rules).where("promotion_rules.start_on <= ? and promotion_rules.end_on >= ?", today, today)
  end
end
