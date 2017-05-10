class CreateCouponLists < ActiveRecord::Migration[5.0]
  def change
    create_table :coupon_lists do |t|
      t.string :name
      t.integer :validity_type
      t.date :valid_from
      t.date :valid_to
      t.integer :fixed_begin_term
      t.integer :fixed_term

      t.timestamps
    end
  end
end
