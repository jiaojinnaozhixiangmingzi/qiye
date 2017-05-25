class UserCard < ApplicationRecord
  belongs_to :user
  has_many :user_card_logs

  def charge1(user_card_charge_setting, money)
    @userCardLog = UserCardLog.create(kind: 3, real_money: money, fake_money:
        user_card_charge_setting.money_give, user_card: self, loggable: user_card_charge_setting)
    self.update_attributes(real_money: self.real_money + money, fake_money: self.fake_money +
        user_card_charge_setting.money_give)
    return @userCardLog
  end

  def charge(realMoney, money)
    # @userCardLog = UserCardLog.create(kind: 3, real_money: realMoney, fake_money:
    #     money, user_card: self)
    self.update_attributes(real_money: self.real_money + realMoney, fake_money: self.fake_money +
        money)
    return @userCardLog
  end
end
