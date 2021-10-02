class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top #管理者トップページ(注文履歴一覧)
    @orders = Order.all
  end
end