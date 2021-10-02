class Item < ApplicationRecord

  belongs_to :genre
  has_many :cart_items
  has_many :orders
  has_many :order_details, dependent: :destroy
  attachment :image

  validates :genre_id, :name, :introduction, presence: true
  validates :price, numericality: { only_integer: true }

  ## 消費税を求めるメソッド
  def with_tax_price
      (price * 1.1).floor
  end
end
