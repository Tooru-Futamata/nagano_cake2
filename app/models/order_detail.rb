class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order

  validates :item_id, :order_id, presence: true
  validates :price, :amount, numericality: { only_integer: true }

  enum making_status: {
    製作不可: '製作不可',
    製作待ち: '製作待ち',
    製作中: '製作中',
    製作完了: '製作完了'
  }

  def subtotal
    self.item.price * self.amount
  end
end
