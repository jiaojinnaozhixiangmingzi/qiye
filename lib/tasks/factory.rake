task :factory_process_records => :environment do
  DatabaseCleaner.strategy = :truncation, {:only => [:factory_process_records]}
  DatabaseCleaner.clean

  sql = "insert into factory_process_records (factory_id, category_id, product_id, process_on, amount)
  select o.factory_id, p.category_id, p_i.product_id, date(p_i.created_at), count(1) from orders o
  left outer join product_items p_i on o.id = p_i.order_id
  left outer join products p on p_i.product_id = p.id
  where o.factory_id is not null and p_i.created_at between '2017-01-01' and '2017-06-30'
  group by date(p_i.created_at), o.factory_id, p_i.product_id;"

  ActiveRecord::Base.connection.execute(sql)
end

task :factory_settlement_records => :environment do
  DatabaseCleaner.strategy = :truncation, {:only => [:factory_settlement_records]}
  DatabaseCleaner.clean

  # cleanup data
  factory = Factory.find_by_mobile('1' * 13)

  1.upto(6).each do |month|
    from_date = Date.new(2017, month, 1)

    settlement_price = factory.get_settlement_price(from_date)

    factory.factory_process_records.where('process_on between ? and ?', from_date, from_date.end_of_month).group(:product_id).sum(:amount).each do |product_id, amount|
      product = Product.find(product_id)
      FactorySettlementRecord.create(settlement_on: from_date, factory: factory, product_id: product_id, amount: amount, price: settlement_price[product_id], money: amount * settlement_price[product_id], category: product.category)
    end  
  end
end