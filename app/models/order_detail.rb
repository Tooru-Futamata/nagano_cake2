class OrderDetail < ApplicationRecord
 has_many :item
  has_many :order

  validates :item_id, :order_id, presence: true
  validates :price, :amonut, numericality: { only_integer: true }

  enum making_status: { notmaking: 0, standby: 1, making: 2, finish: 3 }
end
