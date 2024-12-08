class CreateSales < ActiveRecord::Migration[8.0]
  def change
    create_table :sales do |t|
      t.datetime :realization_date
      t.decimal :total_amount
      t.references :employee, null: false, foreign_key: { to_table: :users }
      t.string :customer_dni
      t.string :customer_name

      t.timestamps
    end
  end
end
