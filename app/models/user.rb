class User < ApplicationRecord
  has_many :orders
  has_one :user_card
  has_many :deliver_waybills, as: :sender, class_name: Waybill
  has_many :pickup_waybills, as: :receiver, class_name: Waybill

  after_create do
    self.create_user_card
  end
end
