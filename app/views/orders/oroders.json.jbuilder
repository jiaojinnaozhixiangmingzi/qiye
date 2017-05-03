json.extract! order, :id, :category_id, :user_id, :address_id, :total_price, :status, :courier_status,
              :voucher_status, :cleaning_status
json.url worker_url(order, format: :json)
