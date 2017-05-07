module OrdersHelper
  def show_order_courier_status(status)
    case status
      when 0
        '待取'
      when 1
        '取送人员-站点'
      when 2
        '站点-工厂'
      when 3
        '工厂-站点'
      when 4
        '站点-取送人员'
      when 5
        '待签收'
    end
  end

  def show_order_voucher_status(status)
    case status
      when 0
        '待支付'
      when 1
        '已支付'
    end
    end

  def show_order_cleaning_status(status)
    case status
      when 0
        '待清洗'
      when 0
        '清洗完成'
    end
  end
end
