class Public::OrdersController < ApplicationController

 before_action :authenticate_customer!

  def new #注文情報入力画面(支払方法・配送先の選択)
    @order = Order.new
    @customer = current_customer
    @address = Address.all
  end

  def confirm #注文情報確認画面
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items
    if params[:order][:address_number] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    elsif params[:order][:address_number] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    end
  end

  def complete #注文完了画面
  end

  def create #注文確定処理
    @order = current_customer.orders.new(order_params)
    @order.customer_id = current_customer.id
    @order.save!
    #order_detailのデータを入れる
    @cart_items = current_customer.cart_items
    @current_customer.cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.order_id = @order.id
      @order_detail.item_id = cart_item.item_id
      @order_detail.price = cart_item.item.price
      @order_detail.amount = cart_item.amount
      @order_detail.save
    end
    current_customer.cart_items.destroy_all
    redirect_to orders_complete_path
  end

  def index #注文履歴画面
    @orders = Order.all
  end

  def show #注文履歴詳細画面
    @order = Order.find(params[:id])
    @sum = 0
    @order.order_details.each do |order_detail|
    @sum += order_detail.subtotal
    end
  end

  private
  def order_params
      params.require(:order).permit(:payment_method, :postal_code, :address, :name, :shipping_cost, :total_payment)
  end

end