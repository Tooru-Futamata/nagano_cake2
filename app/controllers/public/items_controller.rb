class Public::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new(item_id: @item.id)
  end

  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :image_id, :introduction, :price, :is_active)
  end
end
