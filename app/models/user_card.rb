class UserCard < ApplicationRecord
  belongs_to :user
  has_many :user_card_logs

  def charge(user_card_charge_setting)
    @userCardLog = UserCardLog.create(kind: 3, real_money: user_card_charge_setting.min, fake_money:
        user_card_charge_setting.money_give, user_card: self, loggable: user_card_charge_setting)
    self.update_attributes(real_money: self.real_money + user_card_charge_setting.min, fake_money: self.fake_money +
        user_card_charge_setting.money_give)
    return @userCardLog
  end
end
