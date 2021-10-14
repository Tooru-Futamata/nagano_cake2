class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order

  validates :item_id, :order_id, presence: true
  validates :price, :amount, numericality: { only_integer: true }

  enum making_status: { 製作不可: 0, 製作待ち: 1, 製作中: 2, 製作済み: 3 }

  def subtotal
    self.item.price * self.amount
  end
end
