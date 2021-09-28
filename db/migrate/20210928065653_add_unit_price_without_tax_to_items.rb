class AddUnitPriceWithoutTaxToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :unit_price_without_tax, :integer
  end
end
