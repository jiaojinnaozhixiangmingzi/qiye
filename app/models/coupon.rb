class Coupon < ApplicationRecord
  belongs_to :coupon_list
  belongs_to :user

  before_create do 
    case self.coupon_list.validity_type
    when 0
      self.valid_from = self.coupon_list.valid_from
      self.valid_to = self.coupon_list.valid_to
    when 1
      self.valid_from = Date.today + self.coupon_list.fixed_begin_term.days
      self.valid_to = Date.today + (self.coupon_list.fixed_begin_term + self.coupon_list.fixed_term).days
    end
  end

  def refund
    self.update_attribute(:used, false)
  end
end
