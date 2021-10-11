class Public::OrdersController < ApplicationController

 before_action :authenticate_customer!

  def new #注文情報入力画面(支払方法・配送先の選択)
      @order = Order.new
    	@addresses = Address.where(customer: current_customer)
  end

  def confirm #注文情報確認画面
    @order = Order.new(order_params)
    render :new if @order.invalid?
    @address = Address.find(params[:order][:address_id])
    @order.postal_code = @address.postal_code
    @order.address = @address.address
    @order.name = @address.name
    if @address_number == "1"
        @order.address = current_customer.address
        @order.postal_code = current_customer.postal_code
        @order.name = current_customer.full_name
    elsif @address_number == "2"
        @address=Address.find(@address_id)
        @order.address = @address.post_code
        @order.posta_code = @address.address
        @order.name = @address.name
    else
        @address=Address.new
        @address.postal_code = order_params[:postal_code]
        @address.address = order_params[:address]
        @address.name = order_params[:name]
    end
  end

  def complete #注文完了画面
  end

  def create #注文確定処理
    @order = current_customer.orders.new(order_params)
    @order.save
    redirect_to orders_complete_path
  end

  def index #注文履歴画面
    @orders = Order.all
  end

  def show #注文履歴詳細画面
    @order = Order.find(params[:id])
    @sum = 0
    @order.order_details.each do |order_detail|
      @sum += order_detail.amount * order_detail.price
    end
  end

  private
  def order_params
      params.require(:order).permit(:payment_method, :postal_code, :address, :name)
  end

end