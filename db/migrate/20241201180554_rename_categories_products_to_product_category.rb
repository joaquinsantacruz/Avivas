class RenameCategoriesProductsToProductCategory < ActiveRecord::Migration[8.0]
  def change
    rename_table :product_category, :categories_products
  end
end
