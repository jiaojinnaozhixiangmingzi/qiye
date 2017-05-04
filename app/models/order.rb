class Order < ApplicationRecord
  belongs_to :category
  belongs_to :user
  belongs_to :address

  has_many :waybills

  has_one :waybill

  has_many :items
  has_many :product_items


  def paidan
    u_t_c = self.waybills.create(sender: self.user, receiver: Courier.first, exp_time: Time.now + 2.hours, status: 1)
    c_t_f = self.waybills.create(sender: Courier.first, receiver: Factory.first)

    self.waybill = u_t_c
    u_t_c.waybill = c_t_f
  end

  def createWaybill
    u_t_c = self.waybills.create(sender: self.user, receiver_type: 'Courier', exp_time: Time.now + 5.hours)
    c_t_f = self.waybills.create(sender_type: 'Courier', receiver_type: 'Factory')
    f_t_c = self.waybills.create(sender_type: 'Factory', receiver_type: 'Courier')
    c_t_u = self.waybills.create(sender_type: 'Courier', receiver: self.user)

    u_t_c.waybill = c_t_f
    c_t_f.waybill = f_t_c
    f_t_c.waybill = c_t_u
    self.waybill = u_t_c


  end

  def gen_product_items
    self.items.each do |item|
      item.amount.times do
        self.product_items.create(product: item.product)
      end
    end
  end
end
