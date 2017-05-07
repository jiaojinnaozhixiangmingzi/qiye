class Worker < ApplicationRecord
   rolify
   # Include default devise modules. Others available are:
   #:confirmable, :lockable, :timeoutable and :omniauthable
   devise :database_authenticatable,
          :recoverable, :rememberable, :trackable, :validatable, :lockable

  has_and_belongs_to_many :cities

  has_many :user_card_logs, as: :loggable

  def to_s
    self.email
  end
end
