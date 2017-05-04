include Math
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


  def findStation
    @userAddress = Address.find_by_sql(["SELECT * FROM addresses WHERE id = ?;", self.address.id])
    lat1 = @userAddress[0].lat
    lng1 = @userAddress[0].lng
    @addresses = Address.find_by_sql("SELECT * FROM addresses WHERE addressable_type = 'Station';")
    distance = -1
    stationId = 1
    length = @addresses.length - 1
    for i in 0..length do
      @address = @addresses[i]
      lat2 = @address.lat
      lng2 = @address.lng
      lat_diff = (lat1 - lat2)*PI/180.0
      lng_diff = (lng1 - lng2)*PI/180.0
      lat_sin = Math.sin(lat_diff/2.0) ** 2
      lng_sin = Math.sin(lng_diff/2.0) ** 2
      first = Math.sqrt(lat_sin + Math.cos(lat1*PI/180.0) * Math.cos(lat2*PI/180.0) * lng_sin)
      result = Math.asin(first) * 2 * 6378137.0
      if distance < 0 or result < distance
        distance = result
        stationId = @address.addressable_id
      end
    end

    return stationId
    end

  def findFactory
    stationId = self.findStation
    @factories = Factory.find_by_sql(["SELECT * FROM factories where id = (SELECT factory_id FROM factories_stations
WHERE station_id = ?);", stationId])

    return @factories[0].id
  end

  def createWaybill
    stationId = self.findStation
    factoryId = self.findFactory
    u_t_c = self.waybills.create(sender: self.user, receiver_type: 'Courier', exp_time: Time.now + 5.hours)
    c_t_s = self.waybills.create(sender_type: 'Courier', receiver_type: 'Station', receiver_id: stationId)
    s_t_f = self.waybills.create(sender_type: 'Station', sender_id: stationId, receiver_type: 'Factory', receiver_id:
        factoryId)
    f_t_s = self.waybills.create(sender_type: 'Factory', sender_id: factoryId, receiver_type: 'Station', receiver_id:
        stationId)
    s_t_c = self.waybills.create(sender_type: 'Station', sender_id: stationId, receiver_type: 'Courier')
    c_t_u = self.waybills.create(sender_type: 'Courier', receiver: self.user)
    u_t_c.waybill = c_t_s
    c_t_s.waybill = s_t_f
    s_t_f.waybill = f_t_s
    f_t_s.waybill = s_t_c
    s_t_c.waybill = c_t_u
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
