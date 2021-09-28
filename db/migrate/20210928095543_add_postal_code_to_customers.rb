class AddPostalCodeToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :postal_code, :string
  end
end
