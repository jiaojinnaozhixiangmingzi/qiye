class CreateOrderPromotions < ActiveRecord::Migration[5.0]
  def change
    create_table :order_promotions do |t|
      t.integer :kind
      t.float :discount
      t.float :premise
      t.references :coupon_list

      t.timestamps
    end
  end
end
