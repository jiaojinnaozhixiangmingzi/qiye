class PromotionRule < ApplicationRecord
  belongs_to :coupon_list
  has_and_belongs_to_many :cities
end
