class SettlementPrice < ApplicationRecord
  belongs_to :settlement_rule
  belongs_to :product
end
