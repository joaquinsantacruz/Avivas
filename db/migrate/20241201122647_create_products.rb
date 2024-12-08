class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.decimal :unit_price, precision: 10, scale: 2, default: 0.0
      t.integer :available_stock, default: 0
      t.references :category, null: false, foreign_key: true
      t.string :size
      t.string :color
      t.datetime :entry_date
      t.datetime :deleted_date, null: true

      t.timestamps
    end
  end
end
