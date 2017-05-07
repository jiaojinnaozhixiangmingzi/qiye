json.extract! user_card_log, :id, :kind, :real_money, :fake_money, :loggable_type, :loggable_id, :created_at, :updated_at
json.url user_card_log_url(user_card_log, format: :json)