class CreateSettlementPrices < ActiveRecord::Migration[5.0]
  def change
    create_table :settlement_prices do |t|
      t.references :settlement_rule, foreign_key: true
      t.references :product, foreign_key: true
      t.float :price, default: 0

      t.timestamps
    end
  end
end
