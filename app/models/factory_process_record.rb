class FactoryProcessRecord < ApplicationRecord
  belongs_to :factory
  belongs_to :category
  belongs_to :product
end
