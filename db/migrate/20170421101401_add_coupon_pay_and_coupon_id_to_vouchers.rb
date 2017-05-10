class AddCouponPayAndCouponIdToVouchers < ActiveRecord::Migration[5.0]
  def change
    add_column :vouchers, :coupon_pay, :float, default: 0
    add_reference :vouchers, :coupon
  end
end
