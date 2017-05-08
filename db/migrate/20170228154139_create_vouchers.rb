class CreateVouchers < ActiveRecord::Migration[5.0]
  def change
    create_table :vouchers do |t|
      t.references :order, foreign_key: true
      t.integer :status, default: 0
      t.datetime :payed_at
      t.float :money
      t.float :user_card_pay, default: 0

      t.timestamps
    end
  end
end
