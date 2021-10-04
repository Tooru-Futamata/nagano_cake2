class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :customer

  validates :item_id, presence: true
  #validates :customer_id, presence: true
  validates :amount, numericality:{ only_integer: true }

  # 小計を求めるメソッド
  def subtotal
      item.with_tax_price * amount
  end

end
