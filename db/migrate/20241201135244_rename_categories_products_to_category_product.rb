class RenameCategoriesProductsToCategoryProduct < ActiveRecord::Migration[8.0]
  def change
    rename_table :categories_products, :product_category
  end
end
