class FactorySettlementRule < ApplicationRecord
  belongs_to :factory
  belongs_to :settlement_rule
end
