class CreatePromotionRules < ActiveRecord::Migration[5.0]
  def change
    create_table :promotion_rules do |t|
      t.references :coupon_list, foreign_key: true
      t.date :start_on
      t.date :end_on

      t.timestamps
    end

    create_table :cities_promotion_rules do |t|
      t.references :city
      t.references :promotion_rule

      t.timestamps
    end
  end
end
