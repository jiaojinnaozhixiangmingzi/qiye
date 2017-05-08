class AddUserCardFakeMoneyPayToVouchers < ActiveRecord::Migration[5.0]
  def change
    add_column :vouchers, :user_card_fake_money_pay, :float, default: 0
  end
end
