json.extract! waybill, :id, :status, :sender_type, :sender_id, :receiver_type, :receiver_id, :exp_time, :actual_time, :order_id, :created_at, :updated_at
json.url waybill_url(waybill, format: :json)