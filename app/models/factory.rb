class Factory < ApplicationRecord
  has_one :address, as: :addressable

  has_and_belongs_to_many :stations

  has_many :deliver_waybills, as: :sender, class_name: Waybill
  has_many :pickup_waybills, as: :receiver, class_name: Waybill

  has_many :orders

  has_many :factory_settlement_rules

  has_many :factory_process_records
  has_many :factory_settlement_records

  def get_settlement_price(from_date)
    ret = {}
    self.factory_settlement_rules.where('from_date <= ?', from_date).order(priority: :asc).each do |factory_settlement_rule|
      factory_settlement_rule.settlement_rule.settlement_prices.each do |settlement_price|
        ret[settlement_price.product_id] = settlement_price.price if settlement_price.price != 0
      end
    end

    ret
  end

  def to_s
    self.name
  end
end
