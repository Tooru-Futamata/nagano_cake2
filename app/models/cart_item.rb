class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :customer

  validates :subtotal, presence: true

  def subtotal
    self.item.price * self.amount
  end
end
