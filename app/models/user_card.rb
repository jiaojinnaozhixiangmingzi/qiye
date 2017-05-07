class UserCard < ApplicationRecord
  belongs_to :user
  has_many :user_card_logs

  def charge(real_money, fake_money)
    self.update_attributes(real_money: self.real_money + real_money, fake_money: self.fake_money + fake_money)
  end
end
