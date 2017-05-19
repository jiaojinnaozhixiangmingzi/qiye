task :fake_datas => :environment do



  # create fake data

  settlement_rule = SettlementRule.create(name: '普通结算', city: 'fake_city', category: category)
  category.products.each do |product|
    settlement_rule.settlement_prices.create(product: product, price: product.price.price1 * 0.5)
  end
  FactorySettlementRule.create(from_date: '2017-01-01', factory: factory, settlement_rule: settlement_rule)

  settlement_rule = SettlementRule.create(name: '普通结算', city: city, category: category)

  category.products.each do |product|
    settlement_rule.settlement_prices.create(product: product, price: product.price.price1 * 0.3)
  end
  FactorySettlementRule.create(from_date: '2017-04-01', factory: factory, settlement_rule: settlement_rule)

end