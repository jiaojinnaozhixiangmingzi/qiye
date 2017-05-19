class CreateSettlementRules < ActiveRecord::Migration[5.0]
  def change
    create_table :settlement_rules do |t|
      t.references :category, foreign_key: true
      t.references :city, foreign_key: true
      t.string :name
      t.string :comment

      t.timestamps
    end
  end
end
