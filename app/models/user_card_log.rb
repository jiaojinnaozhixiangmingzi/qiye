class UserCardLog < ApplicationRecord
  belongs_to :user_card
  belongs_to :loggable, polymorphic: true
  # belongs_to :loggable, polymorphic: true
end
