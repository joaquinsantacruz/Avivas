class RenameProductSaleToProductSales < ActiveRecord::Migration[8.0]
  def change
    rename_table :product_sale, :product_sales
  end
end
