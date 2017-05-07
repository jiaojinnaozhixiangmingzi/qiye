json.extract! user_card, :id, :real_money, :balance, :user_id, :created_at, :updated_at
json.url user_card_url(user_card, format: :json)