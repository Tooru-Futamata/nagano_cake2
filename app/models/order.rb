class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  validates :customer_id, :address, :name, presence: true
  validates :postal_code, length: { is: 7 }, numericality: { only_integer: true }
  validates :shipping_cost, :total_payment, numericality: { only_integer: true }

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { unpaid: 0, paid: 1, making: 2, preparation: 3, shipped: 4 }
end
