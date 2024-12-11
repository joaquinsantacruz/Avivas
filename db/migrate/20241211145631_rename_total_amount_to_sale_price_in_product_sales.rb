class RenameTotalAmountToSalePriceInProductSales < ActiveRecord::Migration[8.0]
  def change
    rename_column :product_sales, :total_amount, :sale_price
  end
end
