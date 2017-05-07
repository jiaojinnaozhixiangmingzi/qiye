module UserCardLogsHelper
  def show_user_card_log_kind(kind)
    case kind
    when 1 
      '后台充值'
    when 2
      '订单消费'
    when 3
      '用户充值'
    end
  end
end
