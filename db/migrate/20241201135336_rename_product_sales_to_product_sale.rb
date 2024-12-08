class RenameProductSalesToProductSale < ActiveRecord::Migration[8.0]
  def change
    rename_table :product_sales, :product_sale
  end
end
