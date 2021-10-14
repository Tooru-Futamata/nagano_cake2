class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!

  def index #配送先登録/一覧画面
   @addresses = Address.all
   @address = Address.new
  end

  def edit #配送先編集画面
    @address = Address.find(params[:id])

  end

  def create #配送先の登録
    @addresses = Address.all
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      flash[:notice] = "配送先を新たに登録しました"
      redirect_to addresses_path
    else
      render :index
    end
  end

  def update #配送先の更新
    @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:notice] = "配送先を更新しました"
      redirect_to addresses_path
    else
      render :edit
    end
  end

  def destroy #配送先の削除
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to addresses_path
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
end
