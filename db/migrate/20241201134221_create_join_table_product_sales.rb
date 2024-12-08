class CreateJoinTableProductSales < ActiveRecord::Migration[8.0]
  def change
    create_table :product_sales do |t|
      t.references :product, null: false, foreign_key: true
      t.references :sale, null: false, foreign_key: true
      t.integer :amount_sold
      t.decimal :total_amount, precision: 10, scale: 2

      t.timestamps
    end
  end
end
