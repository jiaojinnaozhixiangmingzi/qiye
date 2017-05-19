class CreateFactorySettlementRules < ActiveRecord::Migration[5.0]
  def change
    create_table :factory_settlement_rules do |t|
      t.date :from_date
      t.integer :priority, default: 0
      t.references :factory, foreign_key: true
      t.references :settlement_rule, foreign_key: true

      t.timestamps
    end
  end
end
