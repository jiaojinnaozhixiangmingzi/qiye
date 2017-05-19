class CreateFactorySettlementRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :factory_settlement_records do |t|
      t.references :factory, foreign_key: true
      t.references :category, foreign_key: true
      t.references :product, foreign_key: true
      t.date :settlement_on
      t.integer :amount, default: 0
      t.float :price, default: 0
      t.float :money, default: 0
    end
  end
end
