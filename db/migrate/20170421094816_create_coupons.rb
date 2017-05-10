class CreateCoupons < ActiveRecord::Migration[5.0]
  def change
    create_table :coupons do |t|
      t.references :coupon_list, foreign_key: true
      t.references :user, foreign_key: true
      t.date :valid_from
      t.date :valid_to

      t.timestamps
    end
  end
end
