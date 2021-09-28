class AddWithdrawalStatusToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :withdrawal_status, :string
  end
end
