class Public::OrdersController < ApplicationController

 before_action :authenticate_customer!

  def new #注文情報入力画面(支払方法・配送先の選択)
      @order = Order.new
    	@addresses = Address.where(customer: current_customer)

  end

  def confirm #注文情報確認画面
    @order = Order.new
    @address = Address.find(params[:order][:address_id])
    @order.postal_code = @address.postal_code
    @order.address = @address.address
    @order.name = @address.name
    if params[:order][:address_number] == "1"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name+current_customer.first_name

    elsif  params[:order][:address_number] ==  "2"
      @order.postal_code = Address.find(params[:order][:address]).postal_code
      @order.address = Address.find(params[:order][:address]).address
      @order.name = Address.find(params[:order][:address]).name

    elsif params[:order][:address_number] ==  "3"
      @address = Address.new()
      @address.address = params[:order][:address]
      @address.name = params[:order][:name]
      @address.postal_code = params[:order][:postal_code]
      @address.customer_id = current_customer.id

    if @address.save
      @order.postal_code = @address.postal_code
      @order.name = @address.name
      @order.address = @address.address
    else
       render 'new'
    end
    end
  end

  def complete #注文完了画面
  end

  def create #注文確定処理
    @order = current_customer.orders.new(order_params)
    @order.save

    current_customer.cart_items.each do |cart_item|
      @order_detail = @order.order_details.build
      @order_detail.order_id = @order.id
      @order_detail.item_id = cart_item.item_id
      @order_detail.amount = cart_item.amount
      @order_detail.price = cart_item.item.price*cart_item.amount
    end
    current_customer.cart_items.destroy_all
    redirect_to orders_complete_path
  end

  def index #注文履歴画面
    @orders = Order.all
  end

  def show #注文履歴詳細画面
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @shipping_cost = 800
  end

  private
  def order_params
      params.require(:order).permit(:payment_method, :postal_code, :address, :name, :address_id, :shipping_cost)
  end

end